class LaunchController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => [:create, :create_external]

  def create
    # In some cases, the params variable isn't populated so get the params from the request object
    params = params || request.params

    #if this request is coming from an external source referrer

    if self.external?(params)
      self.launch_from_cache(params); return if performed?
    end

    # If they're using a browser that doesn't allow 3rd party cookies, this is gonna get ugly
    # Check to see if 3rd partycookies work
    unless cookies[:work?] # && false
      # Hmmm... we're not sure if they work or not.
      # Check to see if we've started the cookie test
      # unless true || params[:include_cookie]
      unless params[:include_cookie]
        #  Ok, we haven't really tested cookies yet
        #  Now let's add a cookie to the session and then start over
        cookies[:work?] = true
        return redirect_to launch_create_path(:include_cookie => true, :params => params)
      else
        # Ok, we tried to set a cookie, but it failed.
        # That means this browser's going to demand that we click-to-launch
        # Let's redirect to "Click to launch button"
     
        self.authorize(request, params || request.params)

        cache_key = rand(10000..9999999).to_s

        Rails.cache.fetch( cache_key, expires_in: 5.minutes ) {|a| @launch.params }

        return redirect_to launch_create_external_path(cache_key: cache_key, canvas_course_id: @launch.canvas_course_id)
      end

    else
      # Yay!  Cookies work!  We can use the happy path
      self.authorize(request, params)
      self.redirect
    end
  end

  def create_external
    @canvas_course_id = params[:canvas_course_id]
    @cache_key = params[:cache_key]
    @remove_navigation = true
  end

protected
  
  def launch_from_cache(params)
    cached_params = Rails.cache.fetch(params[:cache_key])
    if cached_params
      @launch = Launch.new(request, cached_params)

      if cached_params["roles"] == "Instructor"
        redirect_to drill_path(@launch.activity.drill) and return
      elsif cached_params["roles"] == "Learner"
        redirect_to new_drill_attempt_path(@launch.activity.drill) and return
      else
        flash[:error] = "Permissions Error:  Please take a screenshot of this page and email it to your instructor and the Ocill support staff."
        redirect_to :root and return
      end
    end 
  end

  def external?(params)
    (params && params[:external] && params[:cache_key])
  end

  def authorize(request, params)
    @launch = Launch.new(request, params)
    @launch.authorize!

    # sign_out
    sign_in(@launch.user)

  end

  def redirect
    if @launch.unauthorized? || @launch.section == nil
      flash[:error] = @launch.errors.first
      redirect_to :root
    elsif @launch.instructor_to_be_duplicated?
      return redirect_to edit_section_path(@launch.section)
    elsif @launch.learner_to_be_duplicated?
      return redirect_to section_path(@launch.section)
    elsif @launch.instructor_view_drill?
      return redirect_to drill_path(@launch.activity.drill)
    elsif @launch.instructor_pick_course?
      return redirect_to edit_activity_path(@launch.activity)
    elsif @launch.instructor_pick_drill?
      return redirect_to edit_activity_path(@launch.activity)
    elsif @launch.learner_attempt_drill?
      return redirect_to new_drill_attempt_path(@launch.activity.drill)
    end 
  end

end
