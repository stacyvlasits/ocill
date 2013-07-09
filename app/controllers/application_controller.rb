class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, except: [:index, :show]


  def not_found(message='Not Found')
    raise ActionController::RoutingError.new(message)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to courses_path
  end
end
