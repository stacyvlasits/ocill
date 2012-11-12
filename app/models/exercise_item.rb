class ExerciseItem < ActiveRecord::Base
  attr_accessible :graded, :exercise_item_type, :column, :answer, :text, :type, :media_items_attributes
  belongs_to :exercise
  has_many :media_items, :dependent => :destroy
  accepts_nested_attributes_for :media_items, allow_destroy: true
  mount_uploader :file, FileUploader  
end
