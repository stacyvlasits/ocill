class Drill < ActiveRecord::Base
  attr_accessible :instructions, :lesson_id, :position, :prompt, :header_row, :title, :exercises_attributes, :type

  serialize :header_row

  belongs_to :lesson
  has_many :exercises, :dependent => :destroy
  has_many :exercise_items, :through => :exercises
  has_many :media_items, :through => :exercises
  accepts_nested_attributes_for :exercises, allow_destroy: true

  validates_presence_of :type, :title

  after_initialize :set_default_position, :set_default_header_row, :set_default_title
    
  def exercise_items_per_exercise
    self.header_row.size
  end

  def course
    self.lesson.course
  end

  def rows
    self.exercises.size
  end

  def columns
    header_row.size
  end


private

  def set_default_header_row
    self.header_row ||= [ "Header" ]
  end

  def set_default_position
    self.position ||= 1
  end

  def set_default_title 
    self.title ||= "Title"
  end

end
