class Header < ActiveRecord::Base
  attr_accessible :drill_id, :position, :title
  belongs_to :drill
  has_many :exercise_items
  before_save :set_default_position 

  validates :drill_id, presence: true

  def grid_drill=(drill)
    self.drill=drill
  end

private
  def set_default_position
    self.position ||= self.drill.headers.count * 100  
  end
end
