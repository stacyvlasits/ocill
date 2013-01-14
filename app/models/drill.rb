class Drill < ActiveRecord::Base
  attr_accessible :instructions, :lesson_id, :position, :prompt, :header_row, :title, :exercises_attributes, :type

  serialize :header_row, Hash

  belongs_to :lesson
  alias :parent :lesson
  has_many :exercises, :dependent => :destroy
  alias :children :exercises
  has_many :exercise_items, :through => :exercises
  has_many :media_items, :through => :exercises
  accepts_nested_attributes_for :exercises, allow_destroy: true

  validates_presence_of :title

  after_initialize :set_default_position, :set_default_header_row, :set_default_title

  def add_column(header_name)
    self.header_row << { header_row.size.to_s => header_name }
    self.exercises.each do |exercise|
      exercise.exercise_items.new 
    end
  end

  def columns
    header_row.size
  end

  def course
    self.lesson.course unless self.lesson.nil?
  end
    
  def exercise_items_per_exercise
    self.header_row.size
  end

  def rows
    self.exercises.size
  end
  
  def top_pos(obj)
    max = obj.parent.children.map(&:position).max
    if max > 400
      max + max*0.25
    else
      500
    end
  end 



private
  def set_default_header_row
    self.header_row ||= { "0" => "Header" }
  end

  def set_default_position
    self.position ||= 1
  end

  def set_default_title 
    self.title ||= "Title"
  end

end
