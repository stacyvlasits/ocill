class Exercise < ActiveRecord::Base
  attr_accessible :position, :drill_id, :prompt, :title, :weight, :exercise_items_attributes
  belongs_to :drill
  alias :parent :drill
  
  has_many :exercise_items, :dependent => :destroy, :autosave => true
  alias :children :exercise_items

  has_many :media_items, :through => :exercise_items, :autosave => true
  accepts_nested_attributes_for :exercise_items, allow_destroy: true
 
  before_save :set_default_position 

  validates :prompt, :title, :presence => true

  def make_cells_for_row
    (drill.columns-1).times do |num|
      column = drill.header_row[(num+1).to_s]
      self.exercise_items.create(:column => column)
    end
  end
  
  def lesson
    self.drill.lesson
  end

private
  def set_default_position
    self.position ||= self.parent.children.count * 100  
  end
end
