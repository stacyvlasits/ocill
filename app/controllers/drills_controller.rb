class DrillsController < InheritedResources::Base
  load_and_authorize_resource
  respond_to :json
  
  def show
    @drill = Drill.find(params[:id])
    @performances = @drill.attempters.map {|attempter| Performance.new(@drill, attempter)} 
  end

  def read
    @drill = Drill.includes( exercises: :exercise_items ).find(params[:drill_id])    
    respond_to do |format|
      format.html 
      if params[:type]
        format.json { render json: @drill.as_json({ type: params[:type].to_sym}) }        
      else  
        format.json { render json: @drill.as_json }
      end
     # format.json { render json: @drill.as_json }
    end
  end

  def new
    if params[:unit_id]
      @unit = Unit.find(params[:unit_id])
      @drill = @unit.drills.build

    else
      @drill = Drill.new
    end
  end

  def index
        
  end

  def create
    if @drill.type == "DragDrill"
      
      if @drill.save
        redirect_to edit_drill_url(@drill)
        return
      end
    end
  
    super do |format|
      format.html { render :action => "edit" }
    end
    
  end


  def update
    @drill = Drill.find(params[:id])

    if @drill.update_attributes(params[:drill])
      flash[:notice] = "Successfully updated the drill."
    end

    respond_with(@drill) do |format|
      format.html { render :action => "edit" }
      format.json { render json: @drill.as_json }
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
