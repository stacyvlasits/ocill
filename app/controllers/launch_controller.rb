class LaunchController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    @launch = Launch.new(request, params)
    @launch.authorize!

    #TODO deleted line 10 if everything still works
    #   sign_out
    sign_in(@launch.user)
    
    session['launch_params'] = @launch.tool.to_params

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
