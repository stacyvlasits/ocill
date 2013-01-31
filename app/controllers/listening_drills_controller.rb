class ListeningDrillsController < DrillsController
  def show
    @drill = ListeningDrill.find(params[:id])
  end

  def index
    @drills = ListeningDrill.all
  end
  
end
