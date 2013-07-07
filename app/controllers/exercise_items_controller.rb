class ExerciseItemsController < InheritedResources::Base
  load_and_authorize_resource :exercise
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
end
