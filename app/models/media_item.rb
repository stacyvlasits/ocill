class MediaItem < ActiveRecord::Base
  attr_accessible :name, :url, :type
  belongs_to :exercise_item
end
