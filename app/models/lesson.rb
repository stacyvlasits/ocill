class Lesson < ActiveRecord::Base
  attr_accessible :order, :title
  belongs_to :course
  has_many :drills
end
