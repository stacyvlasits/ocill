class Exercise < ActiveRecord::Base

<<<<<<< HEAD
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

=======
  include Comparable

  attr_accessible :fill_in_the_blank, :position, :drill_id, :prompt, :title, :weight, :exercise_items_attributes

  belongs_to :drill
  alias :parent :drill
  
  has_many :exercise_items, :order => "position ASC", :dependent => :destroy, :autosave => true
  alias :children :exercise_items
  
  accepts_nested_attributes_for :exercise_items, allow_destroy: true
  validates :prompt, :presence => true

  after_initialize :set_default_position

  def set_default_position
    self.position ||= 999999
  end

  def audio_name
    File.basename(audio.path || audio.filename) if audio
  end
  
  def <=>(object)
    self.position <=> object.position
  end
  
# start METHODS for grid_drills    
>>>>>>> experiments
  def make_cells_for_row
    (drill.headers.size).times do |num|
      header_id = drill.headers.sort_by(&:position)[num].id
      self.exercise_items.create(:header_id => header_id)
    end
  end
  
  def row
    smaller_siblings.size + 1
  end
<<<<<<< HEAD

  def siblings
    self.drill.exercises.sort_by(&:position) 
  end

  def smaller_siblings
    siblings.select {|sib| sib.position > self.position }
  end

  def bigger_siblings
    siblings.select {|sib| sib.position < self.position }
=======
# end METHODS for grid_drills

# start METHODS for fill_drills  
  def fill_in_the_blank
    self.prompt
  end

  def fill_in_the_blank=(text = "a")
    self.prompt = text
    self.save!
    blanks = text.scan(/\[([^\]]*)/).flatten
    fill_in_the_blank_exercise_items(blanks)
  end

  def fill_in_the_blank_exercise_items(blanks)
    self.exercise_items.destroy_all
    blanks.each_with_index do |blank, index|
      self.exercise_items.create(text: blank, position: index)
    end
  end

# end METHODS for fill_drills 
  def siblings
    self.drill.exercises.sort
  end

  def smaller_siblings
    siblings.select {|sib| sib < self }
  end
  
  def myself
    self
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
>>>>>>> experiments
end
