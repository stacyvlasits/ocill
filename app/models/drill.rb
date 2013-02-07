class Drill < ActiveRecord::Base
  attr_accessible :instructions, :lesson_id, :position, :prompt, :title, :exercises_attributes, :type, :headers_attributes

  belongs_to :lesson
  alias :parent :lesson

  has_many :headers, :dependent => :destroy, :autosave => true 
  has_many :exercises, :dependent => :destroy, :autosave => true
  alias :children :exercises
  has_many :exercise_items, :through => :exercises, :autosave => true
  has_many :media_items, :through => :exercises, :autosave => true
  accepts_nested_attributes_for :exercises, allow_destroy: true
  accepts_nested_attributes_for :headers, allow_destroy: true

  before_save :set_default_values


  # this might need to be moved to the ListeningDrill sublass


  def course
    self.lesson.course unless self.lesson.nil?
  end
  
  def rows
    self.exercises.size
  end
  
  def set_default_values
    set_default_position
    set_default_title    
  end

private
  def set_default_position
    number_of_siblings = Drill.where(:lesson_id => self.lesson_id).count || 0
    self.position ||= (number_of_siblings + 1) * 100
  end

  def set_default_title 
    self.title = "Default Title" unless self.title
  end
end
