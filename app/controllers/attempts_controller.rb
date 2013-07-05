class AttemptsController < InheritedResources::Base
  def new
    if params[:drill_id]
      @attempt = Attempt.create(:drill_id => params[:drill_id])
      @drill = @attempt.drill
      new_responses = Drill.find(params[:drill_id]).exercise_items.count || 1
    else
      not_found 'There is no drill here for you attempt'
    end
    new_responses.times { @attempt.responses.build }
  end

  def show
    @attempt = Attempt.find(params[:id])
    @drill = Drill.find(params[:drill_id])
  end
  
  def create
    super do |format|
      format.html { redirect_to drill_attempt_path(@attempt) }
    end
  end

  def update
    super do |format|
      format.html { redirect_to drill_attempt_path }
    end
  end
end