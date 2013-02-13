class Lesson < ActiveRecord::Base
  attr_accessible :position, :title, :drills_attributes
  belongs_to :course
  alias :parent :course
  has_many :drills, :autosave => true
  has_many :grid_drills, :autosave => true
  alias :children :drills
  has_many :exercises, :through => :drills
  has_many :exercise_items, :through => :drills
  before_save :set_default_values

private
  def set_default_values
    number_of_siblings = Lesson.where(:course_id => self.course_id).count
    self.position ||= (number_of_siblings + 1) * 100
  end
end
