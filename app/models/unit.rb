class Unit < ActiveRecord::Base
  attr_accessible :position, :title, :drills_attributes, :course_id
  belongs_to :course
  alias :parent :course
  has_many :drills, :order => "position ASC", :dependent => :destroy, :autosave => true, :autosave => true
  has_many :grid_drills, :order => "position ASC", :autosave => true
  alias :children :drills
  has_many :exercises, :through => :drills
  has_many :exercise_items, :through => :drills
  accepts_nested_attributes_for :drills

  after_initialize :set_default_position

  validates :course_id, :presence => true
  validates :title, :presence => true
  validates :position, :numericality => { :only_integer => true }
  def set_default_position
    self.position ||= Unit.maximum(:id) + 1
  end
end
