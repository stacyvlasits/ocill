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

  end

  def build!
    all_courses = Course.includes(:roles, :units => :drills)
  	all_courses.all.each do |c|
  		senior_role = 
      @courses[c.id] = c.roles.highest(@user)
      
      c.units.each do |u|
        @units[u.id] = senior_role

        u.drills.each do |d|
          @drills[d.id] = senior_role

        end
      end
  	end
  end  
end
