class Exercise < ActiveRecord::Base
  attr_accessible :position, :drill_id, :prompt, :title, :weight, :exercise_items_attributes
  belongs_to :drill
  has_many :exercise_items, :dependent => :destroy
  has_many :media_items, :through => :exercise_items
  accepts_nested_attributes_for :exercise_items, allow_destroy: true
  after_initialize :set_default_position
  
private
  def set_default_position
    self.position ||= 1
  end
end
