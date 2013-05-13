class AudioExerciseItem < ExerciseItem
  mount_uploader :audio, AudioUploader
  def content
    self.audio
    super
  end
end