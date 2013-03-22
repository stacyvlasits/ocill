class CoursesController < InheritedResources::Base
  def create
    super do |format|
      format.html { redirect_to courses_url }
    end
  end
end
