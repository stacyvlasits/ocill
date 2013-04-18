class LessonsController < InheritedResources::Base
  respond_to :json
<<<<<<< HEAD
=======
  def create
    super do |format|
      format.html { redirect_to lessons_url }
    end
  end

  def update
    super do |format|
      format.html { redirect_to lessons_url }
    end
  end
>>>>>>> experiments
end
