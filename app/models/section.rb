class Section < ActiveRecord::Base
  attr_accessible :lti_course_id
  has_many :activities, :dependent => :destroy
  # TODO:  User or remove course_id

  def duplicate( lti_course_id )
    duplicate = Section.create( lti_course_id )

    self.activities.each do | activity |
      duplicate.activities.create( drill_id: activity.drill_id, course_id: activity.course_id,lti_resource_link_id: params[:resource_link_id] ) 
    end
    duplicate
  end
end
  
