class VideoExerciseItem < ExerciseItem
  mount_uploader :video, VideoUploader
  def content
    self.video
  end
end