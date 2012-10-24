class Drill < ActiveRecord::Base
  attr_accessible :instructions, :order, :prompt, :responses, :title
  belongs_to :lesson
  belongs_to :template
  has_many :exercises, :dependent => :destroy
end
