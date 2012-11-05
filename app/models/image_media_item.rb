class ImageMediaItem < MediaItem
  mount_uploader :url, ImageUploader
end