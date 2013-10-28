class Launch
  require 'oauth/request_proxy/rack_request'
  attr_reader :params, :errors, :tool, :user, :activity, :section, :session
	def initialize(request, params)
    @params = params
    @request = request
    @errors = []
    @tool = nil
    @user = find_user
    authorize!
    @section = find_section
    @activity = find_activity
  end

  def authorize!
    return self if @tool
    if key = @params['oauth_consumer_key']
      if secret = oauth_shared_secrets[key]
        @tool = IMS::LTI::ToolProvider.new(key, secret, @params)
      else
        @tool = IMS::LTI::ToolProvider.new(nil, nil, @params)
        @tool.lti_msg = "Your consumer didn't use a recognized key."
        @tool.lti_errorlog = "You did it wrong!"
        @errors << "Consumer key wasn't recognized"
        return self
      end
    else
      @errors << "No consumer key"
      return self
    end

    if !@tool.valid_request?(@request)
      @errors << "The OAuth signature was invalid"
      return self
    end
    unless Rails.env == "development"
      if Time.now.utc.to_i - @tool.request_oauth_timestamp.to_i > 60*60
        @errors << "Your request is too old."
        return self
      end
    end
    self
  end

  def lti_roles_to_ocill_user_role(lti_roles)
    roles = lti_roles.split(',') if lti_roles
    if roles.include?("Instructor")
      "Instructor" 
    elsif roles.include?("Learner")
      "Learner"      
    else
      "Bad Role" 
    end 
  end

  def unauthorized?
    !authorized?  
  end
  
  def authorized?
    authorize!
    @errors.empty?
  end

  def instructor_view_drill?
    user.role == "Instructor" && self.activity.present? && self.activity.drill.present?
  end

  def instructor_pick_course?
    user.role == "Instructor" && self.activity.present? && self.section.present?
  end  
  
  def instructor_pick_drill?
    user.role == "Instructor" && self.activity.present? && self.activity.drill.present?
  end
  
  def learner_attempt_drill?
    user.role == "Learner" && self.activity.drill.present? && user.roles.create(:name => user.role, :course => self.activity.course) 
  end



  def drill
    self.activity.drill
  end

  def find_user
    role = lti_roles_to_ocill_user_role(params[:roles])
    email = "user#{rand(10000..999999999999).to_s}@example.com"
    password = "pass#{rand(10000..999999999999).to_s}"
    u = User.find_or_create_by_lti_user_id(lti_user_id: params[:user_id], role: role, email: email, password: password)
  end

  def find_section
    Section.find_or_create_by_lti_course_id(lti_course_id: params[:context_id])
  end
  
  def find_activity
    section_id = section.id
    Activity.find_or_create_by_lti_resource_link_id(lti_resource_link_id: params[:resource_link_id], section_id: section_id)
  end

private
  def oauth_shared_secrets
    secrets = {}
    key_values_array = ENV["OAUTH_SHARED_SECRETS"].split(",")
    key_values_array.each do |pair|
      k,v = pair.split("=>")
      secrets[k] = v
    end
    secrets
  end
end