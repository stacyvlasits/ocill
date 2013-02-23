class AudioExerciseItemsController < ExerciseItemsController

  def edit
    @exercise_item = ExerciseItem.find(params[:id])
    @audio_uploader = ExerciseItem.new.audio
  end

  def new
    @exercise_item = ExerciseItem.new
    @audio_uploader = ExerciseItem.new.audio
    @audio = ExerciseItem.new(key: params[:key])

  end
  # def new
  #   @painting = Painting.new(key: params[:key])
  # end
end