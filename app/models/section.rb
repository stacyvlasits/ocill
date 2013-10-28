class Section < ActiveRecord::Base
  attr_accessible :lti_course_id
  has_many :activities
end
  
