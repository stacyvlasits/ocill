class SectionsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  def new
    parent_section_id        = params[:duplicate_session_data][:parent_section_id]
    canvas_course_id        = params[:duplicate_session_data][:canvas_course_id]
    lti_course_id           = params[:duplicate_session_data][:lti_course_id]
    parent_canvas_course_id = params[:duplicate_session_data][:parent_canvas_course_id]
    
    @section = Section.new

    respond_with(@section, parent_section_id, canvas_course_id, lti_course_id, parent_canvas_course_id)
  end

  def create
    
  end



end