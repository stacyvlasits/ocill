class Exercise < ActiveRecord::Base

  # TODO debug positioning it is failing tests

  attr_accessible :position, :drill_id, :prompt, :title, :weight, :exercise_items_attributes
  belongs_to :drill
  
  alias :parent :drill
  
  has_many :exercise_items, :dependent => :destroy, :autosave => true
  alias :children :exercise_items
  
  accepts_nested_attributes_for :exercise_items, allow_destroy: true
 
  before_save :set_default_position 

  validates :prompt, :presence => true

  def <=>(object)
    self.position <=> object.position
  end

  def make_cells_for_row
    (drill.headers.size).times do |num|
      header_id = drill.headers.sort_by(&:position)[num].id
      self.exercise_items.create(:header_id => header_id)
    end
  end
  
  def row
    smaller_siblings.size + 1
  end

  def siblings
    self.drill.exercises.sort_by(&:position) 
  end

  def smaller_siblings
    siblings.select {|sib| sib.position > self.position }
  end

  def bigger_siblings
    siblings.select {|sib| sib.position < self.position }
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
