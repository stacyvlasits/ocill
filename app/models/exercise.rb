class Exercise < ActiveRecord::Base
  attr_accessible :position, :drill_id, :prompt, :title, :weight, :exercise_items_attributes
  belongs_to :drill
  alias :parent :drill
  
  has_many :exercise_items, :dependent => :destroy
  alias :children :exercise_items

  has_many :media_items, :through => :exercise_items
  accepts_nested_attributes_for :exercise_items, allow_destroy: true
 
  after_initialize :set_default_position 

  validates :prompt, :title, :presence => true

  def lesson
    self.drill.lesson
  end

private
  def set_default_position
    # self.position ||= self.parent.children.count * 100  
    self.position ||=  100
  end
end
