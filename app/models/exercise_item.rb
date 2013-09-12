class ExerciseItem < ActiveRecord::Base
  attr_accessible :graded, :header_id, :exercise_item_type, :acceptable_answers, :text, :type, :image, :audio, :video, :panda_audio_id
  # attr_accessible  :encodings  
  attr_accessible :position, :remove_audio, :remove_image, :remove_video # TODO remove "column" from db
  mount_uploader :audio, AudioUploader
#  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader
  serialize :acceptable_answers
  serialize :encodings, Hash

  has_many :responses

  belongs_to :exercise
  belongs_to :header
  validates :exercise_id, :presence => true

  after_initialize :set_default_position
  before_save :cleanup_audio
  
  def panda_audio
    @panda_audio ||= Panda::Video.find(panda_audio_id)
  end

  def self.serialized_attr_accessor(*args)
    args.each do |method_name|
      eval "
        def #{method_name}
          (self.encodings || {})[:#{method_name}]
        end
        def #{method_name}=(value)
          self.encodings ||= {}
          self.encodings[:#{method_name}] = value
        end
        attr_accessible :#{method_name}
      "
    end
  end  

  serialized_attr_accessor :mp3, :ogg  
  
  def cleanup_audio
    if remove_audio
      self.remove_audio!
    end
  end

  def hide_text?
    # TODO Yuck.  why am I reaching into the Drill?
    self.exercise.drill.hide_text
  end

  def answers
    special_answers || acceptable_answers
  end

  def special_answers
    if self.audio.present?
      "1"
    else
      nil
    end
  end

  def set_default_position
    self.position ||= 999999
  end

  alias :parent :exercise
  
  def drill
    self.exercise.drill
  end

  def siblings
    siblings = self.exercise.exercise_items
    siblings.delete(self)
    siblings
  end
end
