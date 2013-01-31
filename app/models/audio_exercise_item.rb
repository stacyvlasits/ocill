class AudioExerciseItem < ExerciseItem
  mount_uploader :audio, SoundUploader
  def content
    self.audio
  end
end