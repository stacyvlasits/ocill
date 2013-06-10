class Exercise < ActiveRecord::Base
  include Comparable
  mount_uploader :audio, AudioUploader
  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader

  attr_accessible :fill_in_the_blank, :position, :drill_id, :prompt, :title, :weight, :exercise_items_attributes, :audio, :image, :audio, :video
  belongs_to :drill
  alias :parent :drill
  has_many :exercise_items, :order => "position ASC", :dependent => :destroy, :autosave => true
  alias :children :exercise_items

  accepts_nested_attributes_for :exercise_items, allow_destroy: true
  validates :prompt, :presence => true

  after_initialize :set_default_position

 
  def answers
    self.exercise_items.map { |exercise_item| exercise_item.answer}
  end

  def set_default_position
    self.position ||= 999999
  end

  def <=>(object)
    self.position <=> object.position
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
  def hint
    self.prompt[/\(.+?\)/]
  end

  def hintless_prompt
    self.prompt.gsub(/\(.+?\)/, '')
  end

  def fill_in_the_blank
    self.prompt
  end

  def fill_in_the_blank=(text = "a")
binding.pry
    self.prompt = text
    self.save!
    blanks = text.scan(/\[([^\]]*)/).flatten
    fill_in_the_blank_exercise_items(blanks)
  end

  def fill_in_the_blank_exercise_items(blanks)
    self.exercise_items.destroy_all
    blanks.each_with_index do |blank, index|
      answers = blank.split('/')
      self.exercise_items.create(acceptable_answers: answers, position: index)
    end
  end
  
  def audio_name
     File.basename(audio.path || audio.filename ) unless audio.to_s.empty?
  end
  # end METHODS for fill_drills


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
end
