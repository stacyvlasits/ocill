class Header < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :drill_id, :position, :title
  belongs_to :drill
  has_many :exercise_items
  before_save :set_default_position 

  validates :drill_id, presence: true

=======
  include Comparable

  attr_accessible :drill_id, :position, :title
  belongs_to :drill
  has_many :exercise_items
  after_initialize :set_default_position 

  validates :drill_id, presence: true

  def <=>(object)
    self.position <=> object.position
  end

>>>>>>> experiments
  def grid_drill=(object)
    self.drill=(object)
  end

  def column
    smaller_siblings.size + 1
  end

  def siblings
<<<<<<< HEAD
    self.drill.headers.sort_by(&:position) 
  end

  def smaller_siblings
    siblings.select {|sib| sib.position > self.position }
  end

  def bigger_siblings
    siblings.select {|sib| sib.position < self.position }
=======
    self.drill.headers.sort
  end

  def smaller_siblings
    siblings.select {|sib| sib < self }
  end

  def bigger_siblings
    siblings.select {|sib| sib > self }
>>>>>>> experiments
  end
    
  def biggest_sibling
    siblings.max
  end

  def lesson
    self.drill.lesson
  end

<<<<<<< HEAD
private
  def set_default_position
    self.position ||= new_position
  end

  def new_position
    biggest_sibling ? biggest_sibling.position + 100 : 100
  end

=======
  def set_default_position
    self.position ||= 999999
  end
>>>>>>> experiments
end