class LaunchController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => [:create, :create_external]

  def create
    # If they're using a browser that doesn't allow 3rd party cookies, this is gonna get ugly
    
    # Check to see if 3rd partycookies work
    unless cookies[:work?]
      # Hmmm... we're not sure if they work or not.
      # Check to see if we've started the cookie test
      
      unless params[:include_cookie]
        #  Ok, we haven't really tested cookies yet
        #  Now let's add a cookie to the session and then start over
        cookies[:work?] = true
        return redirect_to launch_create_path(:include_cookie => true, :params => params)
      else
        # Ok, we tried to set a cookie, but it failed.
        # That means this browser's going to demand that we click-to-launch
        # Let's redirect to "Click to launch button"
        self.authorize
        return redirect_to launch_create_external_path(@launch.tool.to_params)
        
      end

    else
      # Yay!  Cookies work!  Let's do the happy path
      self.authorize
      self.redirect
    end
  end

  def create_external
    self.authorize
    @session = session
    @remove_navigation = true
  end


protected 
  
  def authorize

    @launch = Launch.new(request, params)
    @launch.authorize!

    # sign_out
    sign_in(@launch.user)

    session['launch_params'] = @launch.tool.to_params
  end

  def redirect
    if @launch.unauthorized? 
      flash[:error] = @launch.errors.first
      redirect_to :root
    elsif @launch.instructor_view_drill?
      redirect_to drill_path(@launch.activity.drill)
    elsif @launch.instructor_pick_course?
      redirect_to edit_activity_path(@launch.activity)
    elsif @launch.instructor_pick_drill?
      redirect_to edit_activity_path(@launch.activity)
    elsif @launch.learner_attempt_drill?
      redirect_to new_drill_attempt_path(@launch.activity.drill)
    end 
  end

end
