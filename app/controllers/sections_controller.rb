class SectionsController < ApplicationController
  respond_to :html, :json
  
  def edit    
    @section = Section.find(params[:id])
    respond_with @section
  end

  def duplicate_parent_activities
    @section = Section.find(params[:id])
    @section.duplicate_activities_from_parent
    render json: "Success!"
  end

  def duplication_status
    @section = Section.find(params[:id])
    @section.duplication_status

    render json: @section.duplication_status
  end

end