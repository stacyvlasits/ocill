class Lesson < ActiveRecord::Base
  attr_accessible :position, :title
  belongs_to :course
  has_many :drills
end
