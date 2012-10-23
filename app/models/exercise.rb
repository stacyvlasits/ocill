class Exercise < ActiveRecord::Base
  attr_accessible :column_names, :order, :prompt, :title, :weight
  belongs_to :drill
  has_many :exercise_items
end
