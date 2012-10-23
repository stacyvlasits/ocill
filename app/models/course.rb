class Course < ActiveRecord::Base
  attr_accessible :order, :title
  has_many :lessons
end
