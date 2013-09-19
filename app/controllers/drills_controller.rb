class DrillsController < InheritedResources::Base
  load_and_authorize_resource
  cache_sweeper :navigation_sweeper, :only => [:create, :update, :destroy]
  respond_to :json
  
  def show
    @drill = Drill.find(params[:id])
    @performances = @drill.attempters.map {|attempter| Performance.new(@drill, attempter)} 
  end

  def new
    if params[:unit_id]
      @unit = Unit.find(params[:unit_id])
      @drill = @unit.drills.build
    else
      @drill = Drill.new
    end
  end

  def create
    super do |format|
      format.html { render :action => "edit" }
    end
  end

  def update
    super do |format|
      format.html { render :action => "edit" }
    end
  end

  def destroy
    @drill = Drill.find(params[:id])
    unit = @drill.unit
    @drill.destroy
    super do |format|
      format.html { redirect_to unit_url(unit) }
    end
  end  
  
  def add_column
    @drill = Drill.find(params[:id])
    if @drill.update_attributes(params[:drill])
      flash[:notice] = "Drill Updated."
      if @drill.add_column
        respond_to do |format|
          format.html { redirect_to(:action => 'edit') }
          format.js
        end
      else
        flash[:error] = "Drill Was Not Updated."
        respond_to do |format|
          format.html { redirect_to(:action => 'edit') }
        end
      end
    else
      flash[:error] = "Drill Update Failed."
    end

  end

  def add_row
    @drill = Drill.find(params[:id])
    if @drill.update_attributes(params[:drill])
      if @row = @drill.add_row
        respond_to do |format|
          format.html { redirect_to(:action => 'edit') }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to(:action => 'edit') }
        end
      end
    else
      flash[:error] = "Drill Was Not Updated."
      respond_to do |format|
        format.html { redirect_to(:action => 'edit') }
      end
    end
  end

  def remove_row
    @drill = Drill.find(params[:id])
    if @drill.update_attributes(params[:drill])
      if @row = @drill.remove_row(params[:exercise_id])
        respond_to do |format|
          format.html { redirect_to(:action => 'edit') }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to(:action => 'edit') }
        end
      end
    else
      flash[:error] = "Drill Was Not Updated."
      respond_to do |format|
        format.html { redirect_to(:action => 'edit') }
      end
    end
  end

  def remove_column
    @drill = Drill.find(params[:id])
    if @drill.update_attributes(params[:drill])
      if @drill.remove_column(params[:header_id])
        respond_to do |format|
          format.html { redirect_to(:action => 'edit') }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to(:action => 'edit') }
        end
      end
    else
      flash[:error] = "Drill Was Not Updated."
      respond_to do |format|
        format.html { redirect_to(:action => 'edit') }
      end
    end
  end

end
