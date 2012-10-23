class Drill < ActiveRecord::Base
  attr_accessible :instructions, :order, :prompt, :responses, :title
  belongs_to :lesson
  has_many :exercises
end
