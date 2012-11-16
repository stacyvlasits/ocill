class Drill < ActiveRecord::Base
  attr_accessible :instructions, :lesson_id, :position, :prompt, :column_names, :title, :exercises_attributes, :type
  serialize :column_names, Hash
  
  belongs_to :lesson
  has_many :exercises, :dependent => :destroy
  has_many :exercise_items, :through => :exercises
  has_many :media_items, :through => :exercises
  accepts_nested_attributes_for :exercises, allow_destroy: true

  validates_presence_of :type, :title

  after_initialize :set_default_position, :set_default_column_names, :set_default_title

  def exercise_items_per_exercise
    self.column_names.size
  end

  def course
    self.lesson.course
  end

private

  def set_default_column_names
    self.column_names ||= {:first => "Header"}
  end

  def set_default_position
    self.position ||= 1
  end

  def set_default_title 
    self.title ||= "Title"
  end

end
