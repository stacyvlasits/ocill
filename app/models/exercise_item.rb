class ExerciseItem < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :graded, :header_id, :exercise_item_type, :column, :answer, :text, :type, :image, :audio, :video, :file
  # attr_accessible :media_items_attributes
  mount_uploader :audio, AudioUploader
  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader
=======
  attr_accessible :graded, :header_id, :exercise_item_type, :answer, :text, :type, :image, :audio, :video
  attr_accessible :position # TODO remove "column" from db
  mount_uploader :audio, AudioUploader
  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader
>>>>>>> experiments

  belongs_to :exercise
  belongs_to :header

<<<<<<< HEAD
=======
  after_initialize :set_default_position

  def set_default_position
    self.position ||= 999999
  end

>>>>>>> experiments
  alias :parent :exercise
   
  def audio_name
     File.basename(audio.path || audio.filename ) unless audio.to_s.empty?
  end

  def video_name
    File.basename(video.path || video.filename ) unless video.to_s.empty?
  end
  
  def image_name
    File.basename(image.path || image.filename ) unless image.to_s.empty?
  end

<<<<<<< HEAD
  def file_name
    File.basename(file.path || file.filename ) unless file.to_s.empty?
  end

  def content
    { text: self.text, image: self.image, audio: self.audio, video: self.video, file: self.file }
=======
  def content
    { text: self.text, image: self.image, audio: self.audio, video: self.video }
>>>>>>> experiments
  end
  
  def drill
    self.exercise.drill
  end

  def siblings
    siblings = self.exercise.exercise_items
    siblings.delete(self)
    siblings
  end
<<<<<<< HEAD

=======
>>>>>>> experiments
end
