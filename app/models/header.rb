class Header < ActiveRecord::Base
  attr_accessible :drill_id, :position, :title
  belongs_to :drill
  has_many :exercise_items
  before_save :set_default_position 

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
    self.drill.headers.sort_by(&:position) 
  end

  def smaller_siblings
    siblings.select {|sib| sib.position < self.position }
  end

  def bigger_siblings
    siblings.select {|sib| sib.position > self.position }
  end
    
  def biggest_sibling
    siblings.max
  end

  def lesson
    self.drill.lesson
  end

private
  def set_default_position
    self.position ||= new_position
  end

  def new_position
    biggest_sibling ? biggest_sibling.position + 100 : 100
  end

end