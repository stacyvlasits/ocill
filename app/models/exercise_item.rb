class ExerciseItem < ActiveRecord::Base
  attr_accessible :graded, :header_id, :exercise_item_type, :column, :answer, :text, :type, :image, :audio, :video
  # attr_accessible :media_items_attributes
 
  belongs_to :exercise
  belongs_to :header

  alias :parent :exercise
  # has_many :media_items, :dependent => :destroy, :autosave => true
  # alias :children :media_items
  # accepts_nested_attributes_for :media_items, allow_destroy: true
  before_save :set_default_type, :set_default_header
   
  def content
    self.text
  end
  
  def drill
    self.exercise.drill
  end

  def siblings
    siblings = self.exercise.exercise_items
    siblings.delete(self)
    siblings
  end
  
  
private
  def set_default_type
    self.type = "TextExerciseItem" unless self.type
  end
  def set_default_header
  end
end
