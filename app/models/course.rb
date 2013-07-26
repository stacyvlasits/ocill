 class Course < ActiveRecord::Base
  attr_accessible :position, :title, :units_attributes
  has_many :units, :order => "position ASC", :autosave => true
  alias :children :units
  has_many :drills, :through => :units
  accepts_nested_attributes_for :units, allow_destroy: true
  has_many :roles
  has_many :users, :through => :roles

  validates :position, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :title, :presence => true

  after_initialize :set_default_position

  def set_default_position
    self.position = Course.maximum(:id) + 1
  end
end
