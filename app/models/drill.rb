class Drill < ActiveRecord::Base
  attr_accessible :instructions, :unit_id, :position, :prompt, :title, :exercises_attributes, :type, :headers_attributes, :options

  serialize :options, Hash
  
  belongs_to :unit
  alias :parent :unit
  
  has_many :exercises, :dependent => :destroy, :autosave => true, :order => "position ASC"
  alias :children :exercises
  accepts_nested_attributes_for :exercises, allow_destroy: true
  
  has_many :activities
  has_many :attempts
  has_many :attempters, :through => :attempts, :uniq => true, :source => :user
  has_many :exercise_items, :through => :exercises, :autosave => true
  has_many :images, :as => :imageable
  has_many :headers, :order => "position ASC", :dependent => :destroy, :autosave => true
  accepts_nested_attributes_for :headers, allow_destroy: true
  
  validates :unit_id, :presence => true
  validates :title, :presence => true
  
  before_save :set_default_title
  before_save :set_default_position
  after_commit :flush_user_navigation_caches
  
  def self.serialized_attr_accessor(*args)
    args.each do |method_name|
      eval "
        def #{method_name}
          (self.options || {})[:#{method_name}]
        end
        def #{method_name}=(value)
          self.options ||= {}
          self.options[:#{method_name}] = value
        end
        attr_accessible :#{method_name}
      "
    end
  end

  serialized_attr_accessor :rtl, :hide_text

  def direction
    direction = self.rtl == "1" ? 'dir="rtl"' : 'dir="ltr"'
    direction.html_safe
  end

  def type_abbr
    case self.type
    when "GridDrill"
      "Grid"
    when "FillDrill"
      "FITB"
    else
      ""
    end
  end

  def hide_text?
    self.hide_text == "1"
  end

  def answers
    self.exercise_items.map {|exercise_item| exercise_item.answer}.flatten
  end

  def course
    self.unit.course unless self.unit.nil?
  end
    
  def rows
    self.exercises.size
  end
  
  def as_json(options={})
    { 
      created_at: self.created_at , 
      header_row: self.header_row , 
      id: self.id , 
      instructions: self.instructions , 
      options:  self.options , 
      position: self.position , 
      prompt: self.prompt , 
      title: self.title , 
      unit_id: self.unit_id , 
      updated_at: self.updated_at,
      exercises: self.exercises
     }
  end


private
  def set_default_title
    self.title = "Default Title" if self.title.blank?
  end

  def set_default_position
    self.position ||= Drill.maximum(:id).to_i + 1
  end

private
  def flush_user_navigation_caches
    User.flush_all_navigation_caches    
  end
end
