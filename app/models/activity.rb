class Activity < ActiveRecord::Base
  belongs_to :course
  belongs_to :drill
  belongs_to :section
end
