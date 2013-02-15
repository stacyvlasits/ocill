class RowController < ActionController::Base
  
  def create
    @drill = GridDrill.find(params[:drill])
    
  end

end