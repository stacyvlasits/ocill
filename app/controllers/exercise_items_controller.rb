class ExerciseItemsController < InheritedResources::Base
  respond_to :json
<<<<<<< HEAD
  def edit
    @exercise_item = ExerciseItem.find(params[:id])
    @audio_uploader = ExerciseItem.new.audio
    # @exercise_item = ExerciseItem.find(params[:id])
    # @audio_uploader = @exercise_item.audio
=======

  def edit
    @exercise_item = ExerciseItem.find(params[:id])
    @audio_uploader = @exercise_item.audio
    @audio_uploader.success_action_redirect = edit_exercise_item_url(params[:id])
    # @file_uploader = @exercise_item.file
>>>>>>> experiments
    # @image_uploader = @exercise_item.image
    # @video_uploader = @exercise_item.video
  end

  def new
<<<<<<< HEAD
    @exercise_item = ExerciseItem.new
    @audio_uploader = ExerciseItem.new.audio
    # @exercise_item = ExerciseItem.new
    # @audio_uploader = @exercise_item.audio
=======
    @audio_uploader = ExerciseItem.new.audio
    @audio_uploader.success_action_redirect = "https://www.google.com/"
    # @file_uploader = @exercise_item.file
>>>>>>> experiments
    # @image_uploader = @exercise_item.image
    # @video_uploader = @exercise_item.video
  end

end
