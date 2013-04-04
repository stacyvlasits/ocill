class ExercisesController < InheritedResources::Base
  respond_to :html, :json
  def new
    @drill = Drill.find(params[:drill_id])
    @exercise = Exercise.new(drill_id: params[:drill_id])
    respond_to do |format|
      format.html { redirect_to proc { edit_drill_url(@drill, @exercise) } }
      format.js 
    end 
  end
end
