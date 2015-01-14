class Section < ActiveRecord::Base
  attr_accessible :lti_course_id
  has_many :activities, :dependent => :destroy
  # TODO:  use or remove course_id
  
  def build_activities_from_parent(parent, referrer_course_id)
    canvas = Canvas::API.new(:host => "https://utexas.instructure.com", :token => ENV["UT_CANVAS_TOKEN"])
    
    # get all canvas assignments from the new course
    child_assignments = canvas.get("/api/v1/courses/#{referrer_course_id}/assignments", {'per_page' => '1000'})
    
    while child_assignments.more?
      child_assignments.next_page!
    end

    # create a hash of the assignments
    #  - filter out non-ocill assignments
    #  - Key:   Assignment name
    #  - Value: Resource Link Id
    ocill_child_assignments = {}

    child_assignments.each do |assignment| 
      if assignment["submission_types"].include?("external_tool") && (assignment["external_tool_tag_attributes"]["url"] == "https://ocill.herokuapp.com/launch/create") 

        ocill_child_assignments[assignment["name"]] = assignment["external_tool_tag_attributes"]["resource_link_id"]
      end
    end

    # get all canvas assignments from the old course
    parent_assignments = canvas.get("/api/v1/courses/#{parent.canvas_course_id}/assignments", {'per_page' => '1000'})

    while parent_assignments.more?
      parent_assignments.next_page!
    end

    # create a hash of the assignments
    #  - filter out non-ocill assignments
    #  - Key:   Assignment name
    #  - Value: Resource Link Id
    ocill_parent_assignments = {}

    parent_assignments.each do |assignment| 
      if assignment["submission_types"].include?("external_tool") && (assignment["external_tool_tag_attributes"]["url"] == "https://ocill.herokuapp.com/launch/create") 

        ocill_parent_assignments[assignment["name"]] = assignment["external_tool_tag_attributes"]["resource_link_id"]
      end
    end

    parent.activities.each do | activity |
      if activity.drill_id
        drill_name = ocill_parent_assignments.key(activity.lti_resource_link_id)

        resource_link_id = ocill_child_assignments[drill_name]

        self.activities.create(
          :lti_resource_link_id  =>  resource_link_id,
          :drill_id              =>  drill.id,
          :course_id             =>  drill.course.id
        )

      end
    end

  end
end

