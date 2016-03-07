class ActivitiesController < InheritedResources::Base
  load_and_authorize_resource

  def edit
    super do |format|
      format.html { render :action => "edit" }
    end
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update_attributes!(activities_params)
      if params[:activity][:drill_id].present?
        @drill = Drill.find(params[:activity][:drill_id])
        redirect_to drill_path(@drill)
        flash[:notice] = "Drill chosen successfully."
      end
    else
      flash[:error] = "Updating this Activity Failed."
      redirect_to(:controller => 'launch', :action => 'create')
    end
  end

  private

    def activities_params
      params.require(:activity).permit(:drill_id, :lti_resource_link_id, :section_id, :course_id)
    end

end
