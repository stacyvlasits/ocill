class Unit < ActiveRecord::Base
  attr_accessible :position, :title, :drills_attributes, :course_id
  belongs_to :course, :touch => true
  alias :parent :course
  has_many :drills, :order => "position ASC", :dependent => :destroy, :autosave => true, :autosave => true
  has_many :grid_drills, :order => "position ASC", :autosave => true
  alias :children :drills
  has_many :exercises, :through => :drills
  has_many :exercise_items, :through => :drills
  accepts_nested_attributes_for :drills

  after_initialize :set_default_position
  after_commit :flush_user_navigation_caches
  
  validates :course_id, :presence => true
  validates :title, :presence => true
  validates :position, :numericality => { :only_integer => true }

def duplicate_for(course)
    copy = self.dup
    copy.course_id = course.id
    copy.save

    self.drills.each do |drill|
      drill.duplicate_for(copy)
    end
end

private
  
  def set_default_position
    self.position ||= Unit.maximum(:id).to_i + 1
  end

private
  def flush_user_navigation_caches
    User.flush_all_navigation_caches    
  end
end
