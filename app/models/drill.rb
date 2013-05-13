class Drill < ActiveRecord::Base
  attr_accessible :instructions, :unit_id, :position, :prompt, :title, :exercises_attributes, :type, :headers_attributes

  belongs_to :unit
  alias :parent :unit
  has_many :exercises, :order => "position ASC", :dependent => :destroy, :autosave => true
  alias :children :exercises
  has_many :attempts
  has_many :exercise_items, :through => :exercises, :autosave => true
  has_many :headers, :order => "position ASC", :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :exercises, allow_destroy: true
  accepts_nested_attributes_for :headers, allow_destroy: true
 
  before_save :set_default_title

  def answers
    self.exercise_items.map {|exercise_item| exercise_item.answer}.flatten
  end

  def course
    self.unit.course unless self.unit.nil?
  end
  
  def rows
    self.exercises.size
  end

  def set_default_title
    self.title = "Default Title" if self.title.blank?
  end
end
