class ExerciseItem < ActiveRecord::Base

  attr_accessible :graded, :exercise_item_type, :column, :answer, :text, :type, :media_items_attributes, :image, :audio, :video
  belongs_to :exercise
  alias :parent :exercise
  has_many :media_items, :dependent => :destroy, :autosave => true
  alias :children :media_items
  accepts_nested_attributes_for :media_items, allow_destroy: true
  mount_uploader :file, FileUploader 
  mount_uploader :image, ImageUploader 
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
  
  # def content
  #   # implement in sub classes or return nothing
  #   raise StandardError, "The .content method must be overridden by subclasses"
  # end
  
private
  def set_default_type
    self.type = "TextExerciseItem" unless self.type
  end

  def set_default_column
    (drill.header_row.size-self.siblings.size).times do |n|
      drill.add_header
    end
    self.column = drill.header_row(self.siblings.size.to_s) unless self.column
  end
end
