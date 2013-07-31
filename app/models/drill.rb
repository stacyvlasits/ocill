class Drill < ActiveRecord::Base
  attr_accessible :instructions, :unit_id, :position, :prompt, :title, :exercises_attributes, :type, :headers_attributes, :options

  serialize :options, Hash
  
  belongs_to :unit
  alias :parent :unit
  has_many :exercises, :order => "position ASC", :dependent => :destroy, :autosave => true
  alias :children :exercises
  has_many :attempts
  has_many :exercise_items, :through => :exercises, :autosave => true
  has_many :headers, :order => "position ASC", :dependent => :destroy, :autosave => true
  has_many :images, :as => :imageable
  accepts_nested_attributes_for :exercises, allow_destroy: true
  accepts_nested_attributes_for :headers, allow_destroy: true

  validates :unit_id, :presence => true
  validates :title, :presence => true
  
  before_save :set_default_title
  after_initialize :set_default_position

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


  def answers
    self.exercise_items.map {|exercise_item| exercise_item.answer}.flatten
  end

  def course
    self.unit.course unless self.unit.nil?
  end
    
  def rows
    self.exercises.size
  end

  def set_default_title
    self.title = "Default Title" if self.title.blank?
  end

  def set_default_position
    self.position ||= Drill.maximum(:id) + 1
  end
end
