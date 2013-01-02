class ListeningDrillsController < InheritedResources::Base
  def index
    @drills = ListeningDrill.all
  end

  def new
    @drill = ListeningDrill.new
  end

  def edit
    @drill = ListeningDrill.find(params[:id])
  end

  def create
    @drill = ListeningDrill.new(params[:listening_drill])
    if @drill.save
      redirect_to @drill
    else
      render :action => "new"
    end
  end


end
