class MediaItem < ActiveRecord::Base
  attr_accessible :name, :url, :type, :image
  belongs_to :exercise_item
  alias :parent :exercise_item
  
end
