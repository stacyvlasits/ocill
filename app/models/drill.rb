class Drill < ActiveRecord::Base
  attr_accessible :instructions, :lesson_id, :position, :prompt, :header_row, :title, :exercises_attributes, :type

  serialize :header_row, Hash

  belongs_to :lesson
  alias :parent :lesson
  has_many :exercises, :dependent => :destroy, :autosave => true
  alias :children :exercises
  has_many :exercise_items, :through => :exercises, :autosave => true
  has_many :media_items, :through => :exercises, :autosave => true
  accepts_nested_attributes_for :exercises, allow_destroy: true

  validates_presence_of :title
  before_save :set_default_values

  # this might need to be moved to the ListeningDrill sublass
  def add_column(header_name='Header')
    self.header_row[header_row.size.to_s] = header_name
    if self.exercises.empty?
      self.exercises.create(:title => "Title", :prompt => "Prompt")
    end 
    self.exercises.each do |exercise|
      exercise.exercise_items.create(:column => header_name)
    end
  end

  def add_row(prompt='Prompt')
    exercise = self.exercises.create(:title => "Title", :prompt => prompt)
    exercise.make_cells_for_row
  end
  
  # this might need to be moved to the ListeningDrill sublass
  def columns
    header_row.size
  end

  def course
    self.lesson.course unless self.lesson.nil?
  end
  
  def rows
    self.exercises.size
  end
  
private
  def set_default_values
    set_default_position
    set_default_header_row
    set_default_title    
  end

  def set_default_header_row
    self.header_row = { "0" => "Header" } unless self.header_row.size > 0
  end

  def set_default_position
    number_of_siblings = Drill.where(:lesson_id => self.lesson_id).count
    self.position ||= (number_of_siblings + 1) * 100
   end

  def set_default_title 
    self.title = "Default Title" if self.title.empty? 
  end


end
