class AttemptsController < InheritedResources::Base
  load_and_authorize_resource

  def new
    if params[:drill_id]
      @attempt = current_user.attempts.create(:drill_id => params[:drill_id])
      @drill = Drill.includes(:exercises => :exercise_items).find(params[:drill_id])
      new_responses = @drill.exercise_items.count || 1
      @responses = Array.new(new_responses) { @attempt.responses.create }
    else
      not_found 'There is no drill here for you attempt'
    end
    
  end

  def show
    @attempt = Attempt.includes([:drill, {:responses => :exercise_item}] ).find(params[:id])
    @responses = @attempt.responses
    @drill =  @attempt.drill || Drill.find(params[:drill_id])
  end

  def create
    super do |format|
      format.html { redirect_to drill_attempt_path(@attempt) }
    end
  end

  def update
    super do |format|
      if current_user.is_lti?
        score = @attempt.decimal_score
        result = @tool.post_replace_result!(score)
        if result.success?
          flash[:notice] = "Your score was submitted as #{score*100}%"
        else
          flash[:alert] = "Your score was not submitted.  Please notify OCILL support of the problem."
        end
      end
      format.html { redirect_to drill_attempt_path(@attempt)  }
    end
    
  end
end