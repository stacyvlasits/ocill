class Section < ActiveRecord::Base
  attr_accessible :lti_course_id
  has_many :activities, :dependent => :destroy
  # TODO:  User or remove course_id
end
  
