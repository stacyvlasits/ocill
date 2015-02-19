class ExerciseItem < ActiveRecord::Base
  attr_accessible :graded, :header_id, :exercise_item_type, :acceptable_answers, :text, :type, :image, :audio, :video, :panda_audio_id
  # attr_accessible  :encodings  
  attr_accessible :position, :remove_audio, :remove_image, :remove_video # TODO remove "column" and "deleted_at" from db
  mount_uploader :audio, AudioUploader
#  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader
  serialize :acceptable_answers
  serialize :encodings, Hash

  # default_scope where("deleted_at IS NULL")

  # scope :deleted, -> { unscoped.where("deleted_at IS NOT NULL") }

  has_many :responses

  belongs_to :exercise
  belongs_to :header
  # validates :exercise_id, :presence => true

  after_initialize :set_default_position
  before_save :cleanup_audio

  alias :parent :exercise

  def panda_audio
    @panda_audio ||= Panda::Video.find(panda_audio_id)
  end
  
  def audio_urls
    urls = []
    urls << self.audio_url
    urls << self.mp3
    urls << self.ogg
    urls = urls.compact.reject{|i| i.empty?}.map {|u| u.gsub(/http:/, "https:")}.uniq
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
  
  def drill
    self.exercise.drill
  end

  def siblings
    siblings = self.exercise.exercise_items
    siblings.delete(self)
    siblings
  end

  def as_json(options={})
    if options[:type] == :simple || options[:type] == :shuffle
      { 
        id: self.id , 
        position: self.position , 
        text: self.text,
        graded: self.graded,
        acceptable_answers: self.acceptable_answers
      }
    else
      { 
        id: self.id , 
        updated_at: self.updated_at,
        created_at: self.created_at , 
        position: self.position , 
        text: self.text,
        graded: self.graded,
        audio: self.audio,
        image: self.image,
        video: self.video,
        panda_audio_id: self.panda_audio_id,
        acceptable_answers: self.acceptable_answers
       }
    end
  end
end
