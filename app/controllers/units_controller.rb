class UnitsController < InheritedResources::Base
  respond_to :json
  def create
    super do |format|
      format.html { redirect_to units_url }
    end
  end

  def update
    super do |format|
      format.html { redirect_to units_url }
    end
  end
end
