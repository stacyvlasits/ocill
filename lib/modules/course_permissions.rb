class CoursePermissions
  attr_reader :courses, :units, :drills, :attempts
  
  def initialize(user)
    @user = user
  	@courses = {}
  	@units = {}
  	@drills = {}
    @attempts = {}
  end

  def permit(model, role)
    binding.pry
  end

  def build!
  	Course.all.each do |c|
  		senior_role = @user.senior_role(c)
      @courses[c.id] = senior_role
      
      c.units.each do |u|
        @units[u.id] = senior_role

        u.drills.each do |d|
          @drills[d.id] = senior_role

        end
      end
  	end
  end  
end
