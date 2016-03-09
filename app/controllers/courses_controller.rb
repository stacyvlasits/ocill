class CoursesController < InheritedResources::Base
  load_and_authorize_resource

  def create
    @course = Course.new(course_params)
    if @course.save
      @course.roles.create(:name => "Administrator", :user => current_user)
      flash[:notice] = "Successfully created course."

      redirect_to edit_course_url(@course)
    else
      render :action => 'new'
    end
  end

  def show
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def update
    super do |format|
      format.html { redirect_to edit_course_url(@course) }
    end
  end

  def destroy
    super do |format|
      format.html { redirect_to root_path }
    end
  end

  private

    def course_params
      params.require(:course).permit(:id, :position, :title, units_attributes: [:id, :position, :title, :course_id])
    end


end
