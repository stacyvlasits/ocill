class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :build_current_user_permissions
  before_filter :authorize_mini_profiler

  def build_current_user_permissions
  	current_user.cached_course_permissions if current_user
  end

  def not_found(message='Not Found')
    raise ActionController::RoutingError.new(message)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to :root
  end
  
  def authorize_mini_profiler

    if current_user && current_user.is_admin? 
    binding.pry
      Rack::MiniProfiler.authorize_request
    end
  end
end
