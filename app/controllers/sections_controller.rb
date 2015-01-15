class SectionsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  def new
    
    @parent_section_id       = params["parent-section-id"]
    @canvas_course_id        = params["canvas-course-id"]
    @lti_course_id           = params["lti-course-id"]
    @parent_canvas_course_id = params["parent-canvas-course-id"]
    
    @section = Section.new

    respond_with(@section, @parent_section_id, @canvas_course_id, @lti_course_id, @parent_canvas_course_id)
  end

  def create
    #
  end

end