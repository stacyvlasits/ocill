class Course < ActiveRecord::Base
  attr_accessible :position, :title, :lessons_attributes
  has_many :lessons
  alias :children :lessons
  has_many :drills, :through => :lessons
  accepts_nested_attributes_for :lessons, allow_destroy: true

  after_initialize :set_default_position

  def set_default_position
    self.position ||= 1
  end

  # def drills
  #   self.lessons.collect {|l| l.drills}
  # end
end
