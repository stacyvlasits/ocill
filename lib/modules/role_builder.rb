class RoleBuilder
  attr_reader :failures, :successes

	def initialize(course = "", role_name="", users_and_info=[])
    @course = course
    @role_name = role_name
    @users_and_info = users_and_info
	  @failures = []
    @successes = []
  end

  def save!
    @users_and_info.each do |user_info|
      unless user_info.blank?
        user = User.find_by_email_or_eid(user_info).first 
        role = @course.roles.new( :user => user, :name => @role_name )
        if role.save
          @successes << user_info 
        else
          @failures << user_info
        end
      end
    end    
  end
end