class ExerciseItem < ActiveRecord::Base
  attr_accessible :graded, :header_id, :exercise_item_type, :acceptable_answers, :text, :type, :image, :audio, :video
  attr_accessible :position # TODO remove "column" from db
  mount_uploader :audio, AudioUploader
  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader
  serialize :acceptable_answers

  has_many :responses

  belongs_to :exercise
  belongs_to :header

  after_initialize :set_default_position

  def show_text?
    # TODO Yuck.  why am I reaching into the Drill?
    self.exercise.drill.show_text
  end

  def answers
    special_answers || acceptable_answers
  end

  def special_answers
    if self.audio
      "1"
    else
      nil
    end
  end

  def set_default_position
    self.position ||= 999999
  end

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

  def content
    { text: self.text, image: self.image, audio: self.audio, video: self.video }
  end
  
  def drill
    self.exercise.drill
  end

  def siblings
    siblings = self.exercise.exercise_items
    siblings.delete(self)
    siblings
  end
end
