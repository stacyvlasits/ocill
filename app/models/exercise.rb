class Exercise < ActiveRecord::Base
  include Comparable
  mount_uploader :audio, AudioUploader
  # mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader
  attr_accessible :prompt, :title, :fill_in_the_blank, :position, :drill_id, :weight, :exercise_items_attributes, :audio, :image, :video, :remove_audio, :remove_image, :remove_video, :panda_audio_id
  # attr_accessible  :encodings

  serialize :encodings, Hash

  belongs_to :drill
  alias :parent :drill
  has_many :exercise_items, :dependent => :destroy, :autosave => true, :order => "position ASC"
  alias :children :exercise_items

  default_scope order("position asc")

  accepts_nested_attributes_for :exercise_items, allow_destroy: true
  validates :prompt, :presence => true
  after_initialize :set_default_position

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

  def answers
    self.exercise_items.map { |exercise_item| exercise_item.answer}
  end

  def set_default_position
    self.position ||= 99999999
  end

# start METHODS for grid_drills
  def make_cells_for_row
    (drill.headers.size).times do |num|
      header_id = drill.headers.sort_by(&:position)[num].id
      self.exercise_items.create(:header_id => header_id)
    end
  end
  
  def row
    smaller_siblings.size + 1
  end
# end METHODS for grid_drills

# start METHODS for fill_drills
  def prompt_with_hints
    self.prompt.gsub(/(\(.+?\))/, '<span title="Hint" class="hint">\1</span>')
  end

  def fill_in_the_blank
    self.prompt
  end

  def fill_in_the_blank=(text = "a")
    self.prompt = text
    self.save!
    blanks = text.scan(/\[([^\]]*)/).flatten
    fill_in_the_blank_exercise_items(blanks)
  end

  def fill_in_the_blank_exercise_items(blanks)
    self.exercise_items.each do |ei|
      ei.destroy
    end

    blanks.each_with_index do |blank, index|
      answers = blank.split('/')
      self.exercise_items.create(acceptable_answers: answers, position: index)
    end
  end
  
  def audio_name
     File.basename(audio.path || audio.filename ) unless audio.to_s.empty?
  end
  # end METHODS for fill_drills

  # start METHODS for drag_drills



  # end METHODS for drag_drills

  def siblings
    self.drill.exercises.sort
  end

  def smaller_siblings
    siblings.select {|sib| sib < self }
  end
  
  def myself
    self
  end

  def bigger_siblings
    siblings.select {|sib| sib > self }
  end
    
  def biggest_sibling
    siblings.max
  end

  def unit
    self.drill.unit
  end

  def as_json(options={})
    if ( options[:type] == :DragDrill)
      { 
        id: self.id , 
        position: self.position , 
        prompt: self.prompt , 
        title: self.title , 
        drill_id: self.drill_id , 
        weight: self.weight,
        exercise_items: self.exercise_items.as_json({type: :DragDrill})
      }
    else
      { 
        id: self.id , 
        position: self.position , 
        prompt: self.prompt , 
        title: self.title , 
        drill_id: self.drill_id , 
        weight: self.weight,
        audio: self.audio,
        image: self.image,
        video: self.video,
        panda_audio_id: self.panda_audio_id,
        updated_at: self.updated_at,
        created_at: self.created_at , 
        exercise_items: self.exercise_items
      }
    end
  end
end
