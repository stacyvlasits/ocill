class Exercise < ActiveRecord::Base
  attr_accessible :column_names, :position, :prompt, :title, :weight, :exercise_items_attributes
  belongs_to :drill
  has_many :exercise_items, :dependent => :destroy
  accepts_nested_attributes_for :exercise_items, allow_destroy: true
end
