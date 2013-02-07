class GridDrillsController < DrillsController 
  def show
    @drill = GridDrill.find(params[:id])
  end

  def index
    @drills = GridDrill.all
  end
end