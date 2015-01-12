class Section < ActiveRecord::Base
  attr_accessible :lti_course_id
  has_many :activities, :dependent => :destroy
  # TODO:  use or remove course_id
  
  def build_activities_from_parent(parent, referrer_course_id)
    # get all canvas assignments
    canvas = Canvas::API.new(:host => "https://utexas.instructure.com", :token => "qwert")
    assignments = canvas.get("/api/v1/courses/#{referrer_course_id}/assignments")
    ocill_assignments = assignments.map
    # loop through them and gather the resource_link_id s

    # for each resource_link find a corresponding Activity in Ocill
    
    #create a new Activitiy for this Section that has the id  
    
    # use the activity from the parent to create a new activity
    
    parent.activities.each do |activitiy|
      the_section.activities.create( drill_id: activity.drill_id, course_id: activity.course_id,lti_resource_link_id: params[:resource_link_id] ) 
    end
  end
end