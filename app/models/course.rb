class Course < ActiveRecord::Base
  attr_accessible :position, :title, :lessons_attributes
  has_many :lessons, :autosave => true
  alias :children :lessons
  has_many :drills, :through => :lessons
  accepts_nested_attributes_for :lessons, allow_destroy: true

  before_save :set_default_values

private
  def set_default_values
    number_of_siblings = Course.count
    self.position ||= (number_of_siblings + 1) * 100
  end
end
