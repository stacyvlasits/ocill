class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :p3p_headers
  before_filter :lti_tool
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :build_current_user_permissions
  before_filter :authorize_mini_profiler
  before_filter :navigation?

  def p3p_headers
    response.headers["P3P"] = 'CP="IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT"'
  end

  def build_current_user_permissions
  	current_user.cached_course_permissions if current_user
  end

  def lti_tool
    if session['launch_params']
      key = session['launch_params']['oauth_consumer_key']
      secret = ENV["OAUTH_SHARED_SECRETS"].split(",").first().split("=>").last()
      tool = IMS::LTI::ToolProvider.new(key, secret, session['launch_params'])
      tool.outcome_service? ? @tool = tool : nil
    end
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
      Rack::MiniProfiler.authorize_request
    end
  end

  def navigation?
    if current_user
      @remove_navigation = current_user.is_lti?
    else
      @remove_navigation = false
    end
  end
end
