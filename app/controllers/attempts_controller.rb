class AttemptsController < InheritedResources::Base
  load_and_authorize_resource

  def new
    if params[:drill_id]
      @attempt = current_user.attempts.new(:drill_id => params[:drill_id])
      @drill = Drill.includes(:exercises => :exercise_items).find(params[:drill_id])
      new_responses = @drill.exercise_items.count || 1
      @responses = Array.new(new_responses) { @attempt.responses.new }
      respond_with @attempt
    else
      not_found 'There is no drill here for you attempt'
    end
  end

  def create
    if params[:drill_id]
      @attempt = current_user.attempts.new(:drill_id => params[:drill_id])
      params[:attempt][:responses_attributes].each do |response| 
        @attempt.responses.new(id: response[0], exercise_item_id: response[1][:exercise_item_id], value: response[1][:value])
      end
      if @attempt.save 
        flash[:notice] = "Successfully saved your attempt."
        respond_with @attempt
      else
        flash[:error] = "Failed to save your attempt."
      end
    else
      not_found 'There is no drill to create an attempt for.'
    end
  end

  def show
    @attempt = Attempt.includes([:drill, {:responses => :exercise_item}] ).find(params[:id])
    @responses = @attempt.responses
    @drill =  @attempt.drill || Drill.find(params[:drill_id])
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