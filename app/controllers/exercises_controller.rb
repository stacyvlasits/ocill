class ExercisesController < InheritedResources::Base
  respond_to :html, :json
  def new
    @drill = Drill.find(params[:drill_id])
    @exercise = Exercise.new(drill_id: params[:drill_id])
    respond_to do |format|
      format.html { redirect_to root_path  }
      format.js 
    end 
  end
end
