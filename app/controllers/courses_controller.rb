class CoursesController < InheritedResources::Base
<<<<<<< HEAD
=======
  def create
    super do |format|
      format.html { redirect_to courses_url }
    end
  end

  def update
    super do |format|
      format.html { redirect_to courses_url }
    end
  end
>>>>>>> experiments
end
