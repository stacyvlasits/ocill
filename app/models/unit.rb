class Unit < ActiveRecord::Base
  attr_accessible :position, :title, :drills_attributes, :course_id
  belongs_to :course
  alias :parent :course
  has_many :drills, :order => "position ASC", :autosave => true
  has_many :grid_drills, :order => "position ASC", :autosave => true
  alias :children :drills
  has_many :exercises, :through => :drills
  has_many :exercise_items, :through => :drills
  accepts_nested_attributes_for :drills

  validates :course_id, :presence => true
end
