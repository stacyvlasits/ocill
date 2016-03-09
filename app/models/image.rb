class Image < ActiveRecord::Base
  # ToDo delete after removing protected attributes gem
  #  attr_accessible :image, :imageable_id, :imageable_type
  mount_uploader :image, ImageUploader
end
