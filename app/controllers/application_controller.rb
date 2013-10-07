class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :build_current_user_permissions

  def build_current_user_permissions
  	current_user.course_permissions if current_user
  end

  def not_found(message='Not Found')
    raise ActionController::RoutingError.new(message)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to :root
  end
end
