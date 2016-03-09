class ExercisesController < InheritedResources::Base
  load_and_authorize_resource :drill
  load_and_authorize_resource :exercise, :through => :drill
  respond_to :html, :json
  
  def new
    @drill = Drill.find(params[:drill_id])
    @exercise = Exercise.new(drill_id: params[:drill_id])
    respond_to do |format|
      format.html { redirect_to proc { edit_drill_url(@drill, @exercise) } }
      format.js
    end
  end

  def remove_audio
    exercise = Exercise.find(params[:exercise_id])
    exercise.remove_audio!
    if exercise.save!
      flash[:notice] = "Audio file removed"
    else
      flash[:error] = "Audio file not removed"
    end
    redirect_to edit_drill_path(exercise.drill)
  end

  def remove_image
    exercise = Exercise.find(params[:exercise_id])
    exercise.remove_image!
    if exercise.save!
      flash[:notice] = "Image file removed"
    else
      flash[:error] = "Image file not removed"
    end
    redirect_to edit_drill_path(exercise.drill)
  end

  private
    def exercise_params
      params.require(:exercise).permit(:id, :prompt, :title, :fill_in_the_blank, :position, :drill_id, :weight, :audio, :image, :video, :remove_audio, :remove_image, :remove_video, :panda_audio_id, :horizontal, :options, exercise_items_attributes: [ :graded, :header_id, :exercise_item_type, :acceptable_answers, :text, :type, :image, :audio, :video, :panda_audio_id, :options, :position, :remove_audio, :remove_image, :remove_video, :id ])
    end
end
