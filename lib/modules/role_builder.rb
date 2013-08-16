class RoleBuilder
  attr_reader :failures, :successes

	def initialize(course = "", role_name="", user_identifiers=[], creator)
    @creator = creator
    @course = course
    @role_name = role_name
    @user_identifiers = user_identifiers
	  @failures = []
    @successes = []
  end

  def save!
    roles = []
    @user_identifiers.each do |email|
      unless email.blank?
        user = User.find_or_create_by_email(email, @role_name, @creator).first 
        roles << role = @course.roles.new( :user => user, :name => @role_name )
        if role.save
          @successes << email 
        else
          @failures << email
        end
      end
    end
    roles    
  end
end