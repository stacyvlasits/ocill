class Activity < ActiveRecord::Base
 # ToDo delete after removing protected attributes gem
 # attr_accessible :drill_id, :lti_resource_link_id, :section_id, :course_id
  belongs_to :course
  belongs_to :drill
  belongs_to :section


end
