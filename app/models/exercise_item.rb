class ExerciseItem < ActiveRecord::Base

  attr_accessible :graded, :exercise_item_type, :column, :answer, :text, :type, :media_items_attributes, :image, :audio, :video
  belongs_to :exercise
  alias :parent :exercise
  has_many :media_items, :dependent => :destroy, :autosave => true
  alias :children :media_items
  accepts_nested_attributes_for :media_items, allow_destroy: true
  scope :by_column, order("column")

  before_save :set_default_column, :set_default_type

  validates :column, :uniqueness => {:scope => :exercise_id}
  
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

  def set_default_column
    headers_needed=self.siblings.size-drill.header_row.size
    if headers_needed > 0
      headers_needed.times do |n|
        drill.add_header
      end
    end
    drill.save
    self.column = drill.header_row(self.siblings.size.to_s) unless self.column
  end
end
