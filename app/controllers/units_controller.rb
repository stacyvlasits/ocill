class UnitsController < InheritedResources::Base
  load_and_authorize_resource
  respond_to :json

  def new
    @course = Course.find(params[:course_id])
    @unit = @course.units.build
    respond_with @unit
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def create
    if @unit.save
      flash[:notice] = "Successfully created unit."
      redirect_to unit_path(@unit)
    else
      render :action => 'new'
    end
  end

  def update
    @unit = Unit.find(params[:id])
    if @unit.update_attributes(unit_params)
      flash[:notice] = "Successfully updated unit."
      redirect_to unit_path(@unit)
    else
      respond_with(@unit)
    end
  end

  def destroy
    @unit = Unit.find(params[:id])
    title = @unit.title
    course = @unit.course
    @unit.destroy
    flash[:notice] = "Successfully deleted unit: " + title.to_s
    redirect_to course_url(course)
  end

  private
    def unit_params
      params.require(:unit).permit(:id, :position, :title, :course_id, drills_attributes: [:id, :instructions, :unit_id, :position, :prompt, :title, :type, :options ])
    end
end
