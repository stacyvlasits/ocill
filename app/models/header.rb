class Header < ActiveRecord::Base
  attr_accessible :drill_id, :exercise_item_id, :position, :title
  belongs_to :drill
  belongs_to :exercise_item
end
