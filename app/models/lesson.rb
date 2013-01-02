class Lesson < ActiveRecord::Base
  attr_accessible :position, :title, :drills_attributes
  belongs_to :course
  alias :parent :course
  has_many :drills
  alias :children :drills
  has_many :exercises, :through => :drills
  has_many :exercise_items, :through => :drills
  after_initialize :set_default_position

private
  def set_default_position
    self.position ||= 1
  end
end
