class ExerciseItemsController < InheritedResources::Base
  load_and_authorize_resource :exercise
  load_and_authorize_resource :exercise_item, :through => :exercise
  respond_to :json

  def remove_audio
    exercise_item = ExerciseItem.find(params[:exercise_item_id])
    exercise_item.remove_audio!
    if exercise_item.save!
      flash[:notice] = "Audio file removed"
    else
      flash[:error] = "Audio file not removed"
    end
    redirect_to edit_drill_path(exercise_item.exercise.drill)
  end

  private
    def exercise_item_params
      params.require(:exercise_item).permit(:id, :graded, :header_id, :exercise_item_type, :acceptable_answers, :text, :type, :image, :audio, :video, :panda_audio_id, :options)
    end
end
