class Drill < ActiveRecord::Base
  attr_accessible :instructions, :order, :prompt, :responses, :title
end
