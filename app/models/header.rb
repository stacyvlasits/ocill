class Header < ActiveRecord::Base
  include Comparable

  attr_accessible :drill_id, :position, :title
  belongs_to :drill
  has_many :exercise_items
  after_initialize :set_default_position

  validates :drill_id, presence: true

  def <=>(object)
    self.position <=> object.position
  end

  def grid_drill=(object)
    self.drill=(object)
  end

  def column
    smaller_siblings.size + 1
  end

  def siblings
    self.drill.headers.sort
  end

  def smaller_siblings
    siblings.select {|sib| sib < self }
  end

  def bigger_siblings
    siblings.select {|sib| sib > self }
  end
    
  def biggest_sibling
    siblings.max
  end

  def lesson
    self.drill.lesson
  end

  def set_default_position
    self.position ||= 999999
  end
end