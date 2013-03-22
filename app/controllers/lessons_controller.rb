class LessonsController < InheritedResources::Base
  respond_to :json
  def create
    super do |format|
      format.html { redirect_to lessons_url }
    end
  end
end
