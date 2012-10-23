class MediaItem < ActiveRecord::Base
  attr_accessible :name, :url, :type
end
