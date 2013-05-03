class AttemptsController < InheritedResources::Base

  def new
    if params[:drill_id]
      @attempt = Attempt.new(:drill_id => params[:drill_id])
      new_responses = Drill.find(params[:drill_id]).exercise_items.count || 1
    else
      not_found 'There is no drill here for you attempt'
    end
    
    new_responses.times do |t|
      @attempt.responses.new
    end
  end

  def create
    super do |format|
      format.html { redirect_to attempt_path }
    end
  end

end