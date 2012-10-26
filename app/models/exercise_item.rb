class ExerciseItem < ActiveRecord::Base
  attr_accessible :scored, :text, :type, :media_items_attributes
  belongs_to :exercise
  has_many :media_items
  accepts_nested_attributes_for :media_items, allow_destroy: true
end
