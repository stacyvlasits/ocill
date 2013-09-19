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
  #  @unit = Unit.includes(:drills => [{ :attempters => :attempts }, :unit] ).find(params[:id])
 #   @drills = @unit.drills
 #   @drill_performances = @drills.map {|d| d.attempters.map {|attempter| Performance.new(d, attempter)}} 
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
    if @unit.update_attributes(params[:unit])
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
end
