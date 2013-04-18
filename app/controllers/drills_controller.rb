class DrillsController < InheritedResources::Base
  respond_to :json
<<<<<<< HEAD

  def update
    @drill = Drill.find(params[:id])
    if @drill.update_attributes(params[:drill])
      flash[:notice] = "Drill Updated."
      respond_to do |format|
        format.html { redirect_to(:action => 'edit')  }
        format.js 
      end
    else
      render :action => 'edit'
    end  
  end

=======
  
  def perform
    @drill = Drill.find(params[:id])
  end

  def submit
    @drill = Drill.find(params[:id])
      if @drill.update_attributes(params[:drill])
      flash[:notice] = "Successfully updated drill."
      redirect_to @drill
    else
      render :action => 'edit'
    end      
  end


  def new
    if params[:lesson_id] 
      @lesson = Lesson.find(params[:lesson_id])
      @drill = @lesson.drills.build
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
  
>>>>>>> experiments
  def add_column
    @drill = Drill.find(params[:id])
    if @drill.update_attributes(params[:drill])
      flash[:notice] = "Drill Updated."
<<<<<<< HEAD
      if @column = @drill.add_column
=======
      if @drill.add_column
>>>>>>> experiments
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
