class Template < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :drills
end
