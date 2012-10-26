class Drill < ActiveRecord::Base
  attr_accessible :instructions, :position, :prompt, :responses, :title, :exercises_attributes
  belongs_to :lesson
  belongs_to :template
  has_many :exercises, :dependent => :destroy
  accepts_nested_attributes_for :exercises, allow_destroy: true
end
