class AttemptsController < InheritedResources::Base

  def new
    if params[:drill_id] 
      @attempt = Attempt.new(:drill_id => params[:drill_id])
    else
      @attempt = Attempt.new
    end
  end 


end