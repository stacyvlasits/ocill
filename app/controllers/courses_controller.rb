class CoursesController < InheritedResources::Base
  load_and_authorize_resource

  def create
    @course = Course.new(params[:course])
    if @course.save
      @course.roles.create(:name => "Administrator", :user => current_user)
      flash[:notice] = "Successfully created course."

      redirect_to edit_course_url(@course)
    else
      render :action => 'new'
    end
  end

  def update
    super do |format|
      format.html { redirect_to edit_course_url(@course) }
    end
  end


end
