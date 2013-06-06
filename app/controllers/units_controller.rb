class UnitsController < InheritedResources::Base
  respond_to :json
  def create
    @unit = Unit.new(params[:unit])
    if @unit.save
      flash[:notice] = "Successfully created unit."
      redirect_to units_url
    else

      render :action => 'new'
    end
  end

  def update
    @unit = Unit.find(params[:id])
    if @unit.update_attributes(params[:unit])
      flash[:notice] = "Successfully updated unit."
      redirect_to units_url
    else
      respond_with(@unit)
    end
  end
end
