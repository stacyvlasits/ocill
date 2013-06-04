class AudioController < InheritedResources::Base
  respond_to :json

  def new
  
    if params[:exercise_item_id]
      @model= ExerciseItem.find(params[:exercise_item_id])
    elsif params[:exercise_id]
      @model= Exercise.find(params[:exercise_id])
    else
      redirect_to drills_url, :flash => { :error => "Something went wrong."}
    end
    @audio_uploader = @model.audio
    @audio_uploader.success_action_redirect = 'cantresolve.com'
  end

  def edit
    if params[:exercise_item_id]
      @model= ExerciseItem.find(params[:exercise_item_id])
    elsif params[:exercise_id]
      @model= Exercise.find(params[:exercise_id])
    else
      redirect_to drills_url, :flash => { :error => "Something went wrong."}
    end
    @key = params[:key]
    @audio_uploader = @model.audio
  end

end
