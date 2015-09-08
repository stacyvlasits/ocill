class Launch
  require 'oauth/request_proxy/rack_request'
  attr_reader :params, :errors, :tool, :user, :activity, :section, :parent_section, :duplicate_session_data, :request, :session
	
  def initialize(request, params, session)
    @session = session
    @params = params['launch_params'] || params
    @request = request
    @errors = []
    @tool = nil
    @user = find_user
    session[:launch_tool_cache_key] = @user.lti_user_id.to_s + rand(10000..999999).to_s
    authorize!
    @to_be_duplicated = false
    @section = find_section
    @activity = find_activity

  end

  def to_be_duplicated?
    return @to_be_duplicated
  end

  def authorize!
     if key = @params['oauth_consumer_key']
      if secret = oauth_shared_secrets[key]
        @tool = Rails.cache.fetch(session[:launch_tool_cache_key], expires_in: 12.hours) do
          IMS::LTI::ToolProvider.new(key, secret, @params)
        end
      else
        @tool = session[:launch_tool_cache_key] = IMS::LTI::ToolProvider.new(nil, nil, @params)
        @tool.lti_msg = "The consumer didn't use a recognized key."
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
      if Time.now.utc.to_i - @tool.request_oauth_timestamp.to_i > 4.hours
        @errors << "Your request is too old."
        return self
      end
    end
    self
  end

  def lti_roles_to_ocill_user_role(lti_roles)
    roles = lti_roles.split(',') if lti_roles
    if roles.grep(/Instructor/).any?
      "Instructor"
    elsif roles.grep(/TeachingAssistant/).any?
      "Instructor"  
    elsif roles.grep(/[lL]earner/).any?
      "Learner"
    else
      error_message = "The Launch model just created a new user as a Learner, even though the user was not properly identified"
      LoggingMailer.log_email(error_message: error_message, roles: roles,  parameters: @params ).deliver
      "Learner" 
    end 
  end

  def unauthorized?
    !authorized?  
  end
  
  def authorized?
    return @errors.empty? if @tool
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
  
  def instructor_to_be_duplicated?
    user.role == "Instructor" && @to_be_duplicated
  end

  def learner_to_be_duplicated?
    user.role == "Learner" && @to_be_duplicated
  end

  def learner_attempt_drill?
    user.role == "Learner" && self.activity.drill.present? && Role.find_or_create_by_user_id_and_course_id_and_name(user.id, self.activity.course, user.role)
  end

  def find_user
    user_id = params[:user_id] || params["user_id"]
    roles = params[:roles] || params["ext_roles"]
    role = lti_roles_to_ocill_user_role(roles)
    email = "user#{rand(10000..999999999999).to_s}@example.com"
    password = "pass#{rand(10000..999999999999).to_s}"
    u = User.find_or_create_by_lti_user_id(lti_user_id: user_id, role: role, email: email, password: password)
  end

  def find_or_create_child_section(context_id, custom_canvas_course_id)
    if the_section = Section.find_by_lti_course_id(context_id)
      return the_section
    else 
      if parent_section = Section.find_by_canvas_course_id(custom_canvas_course_id)
        # if there is a real course to copy create the Section, save it and return it
        @to_be_duplicated = true
          
        return Section.create(
            canvas_course_id:   canvas_course_id,
            lti_course_id:      context_id,
            parent_id:          parent_section.id
            )
      else
        self.errors.push('"' + custom_canvas_course_id + '" does not match an existing course on your Learning Management System\'s server.  Please check the number in your Ocill External Tool configuration and try again.')
        return nil
      end
    end
  end

  def find_section
    if params[:custom_canvas_course_id]
      the_section = find_or_create_child_section(params[:context_id], params[:custom_canvas_course_id])
    else
      the_section = Section.where(lti_course_id: params[:context_id]).first_or_create do |section|
        section.lti_course_id = params[:context_id]
        section.canvas_course_id = canvas_course_id
      end
    end

    if the_section && the_section.canvas_course_id != canvas_course_id
      the_section.canvas_course_id = canvas_course_id
      the_section.save!       
    end
    the_section
  end
  
  def find_activity
    return nil unless section
    Activity.find_or_create_by_lti_resource_link_id(lti_resource_link_id: params[:resource_link_id], section_id: section.id)
  end

  def canvas_course_id

    referrer_uri = URI.parse(@request.referrer)
    path_parts = referrer_uri.path.split("/")
    course_id_index = path_parts.find_index("courses")
    if course_id_index
      course_id = path_parts[course_id_index + 1]
    else 
      course_id = @request.params["course_id"]
    end
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