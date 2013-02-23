class ExerciseItemsController < InheritedResources::Base

  def edit
    @exercise_item = ExerciseItem.find(params[:id])
    @audio_uploader = ExerciseItem.new.audio
    # @exercise_item = ExerciseItem.find(params[:id])
    # @audio_uploader = @exercise_item.audio
    # @image_uploader = @exercise_item.image
    # @video_uploader = @exercise_item.video
  end

  def new
    @exercise_item = ExerciseItem.new
    @audio_uploader = ExerciseItem.new.audio
    # @exercise_item = ExerciseItem.new
    # @audio_uploader = @exercise_item.audio
    # @image_uploader = @exercise_item.image
    # @video_uploader = @exercise_item.video
  end

end
