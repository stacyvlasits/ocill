class Attempt < ActiveRecord::Base
  attr_accessible :answer_id, :response
  
  has_one :drill
  has_many :exercises, :through => :drills
  belongs_to :user


end
