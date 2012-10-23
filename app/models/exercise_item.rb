class ExerciseItem < ActiveRecord::Base
  attr_accessible :scored, :text, :type
  belongs_to :exercise
  has_many :media_items
end
