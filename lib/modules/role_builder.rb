class RoleBuilder
  attr_reader :failures, :successes

	def initialize(course = "", course_role_name="", user_identifiers=[], creator)
    @creator = creator
    @course = course
    @course_role_name = course_role_name
    @user_identifiers = user_identifiers
	  @failures = []
    @successes = []
  end

  def save!
    course_roles = []
    @user_identifiers.each do |email|
      unless email.blank?
        user = User.find_or_create_by_email(email, @course_role_name, @creator).first 
        course_roles << new_role = @course.roles.new( :user => user, :name => @course_role_name )
        if new_role.save
          @successes << email 
        else
          @failures << email
        end
      end
    end
    course_roles    
  end
end