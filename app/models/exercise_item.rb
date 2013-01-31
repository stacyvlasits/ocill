class ExerciseItem < ActiveRecord::Base

  attr_accessible :graded, :exercise_item_type, :column, :answer, :text, :type, :media_items_attributes, :image, :audio, :video
  belongs_to :exercise
  alias :parent :exercise
  has_many :media_items, :dependent => :destroy
  alias :children :media_items
  accepts_nested_attributes_for :media_items, allow_destroy: true
  mount_uploader :file, FileUploader 
  mount_uploader :image, ImageUploader 
  scope :by_column, order("column")

  def content
    self.text
  end

end
