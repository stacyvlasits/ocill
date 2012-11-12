class ExerciseItemsController < InheritedResources::Base

  def edit
    @exercise_item = ExerciseItem.find(params[:id])
    @uploader = @xercise_item.image
  end

  # def new
  #   @painting = Painting.new(key: params[:key])
  # end
end