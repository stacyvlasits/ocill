class Drill < ActiveRecord::Base
  attr_accessible :instructions, :lesson_id, :position, :prompt, :column_names, :exercise_items_per_exercise, :title, :exercises_attributes
  belongs_to :lesson
  belongs_to :template
  has_many :exercises, :dependent => :destroy
  has_many :exercise_items, :through => :exercises
  has_many :media_items, :through => :exercises
  accepts_nested_attributes_for :exercises, allow_destroy: true
  after_initialize :set_default_position
  serialize :column_names

private
  def set_default_position
    self.position ||= 1
  end
end
