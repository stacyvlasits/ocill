class AudioController < InheritedResources::Base
  respond_to :json  

  def new
    @exercise_item = ExerciseItem.find(params[:id]) || ExerciseItem.new
    @audio_uploader = @exercise_item.audio
    @audio_uploader.success_action_redirect = 'cantresolve.com'
  end

  def edit
    @exercise_item = ExerciseItem.find(params[:id])
    @key = params[:key]
    @audio_uploader = @exercise_item.audio
  end


end
