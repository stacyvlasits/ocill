class CoursePermissions
  attr_reader :courses, :units, :drills, :attempts
  
  def initialize(user)
    @user = user
  	@courses = {}
  	@units = {}
  	@drills = {}
    @attempts = {}
  end

  def build!
    all_courses = Course.includes(:roles, :units => :drills)
  	all_courses.find_each do |c|


      if highest_role = c.roles.highest(@user).first 
  		  senior_role = highest_role.name
      else
        senior_role = ""
      end

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
