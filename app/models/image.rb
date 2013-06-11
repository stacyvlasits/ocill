class Image < ActiveRecord::Base
  attr_accessible :image, :imageable_id, :imageable_type
  mount_uploader :image, ImageUploader
end
