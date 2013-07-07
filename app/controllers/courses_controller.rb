class CoursesController < InheritedResources::Base
  load_and_authorize_resource
  
  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:notice] = "Successfully created course."
      redirect_to courses_url
    else

      render :action => 'new'
    end
  end

  def update
    super do |format|
      format.html { redirect_to courses_url }
    end
  end
end
