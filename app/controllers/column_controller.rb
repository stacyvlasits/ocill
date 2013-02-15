class ColumnController < ActionController::Base
  
  def new
    @drill = GridDrill.find(params[:drill])
  end

end