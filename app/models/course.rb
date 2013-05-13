class Course < ActiveRecord::Base
  attr_accessible :position, :title, :units_attributes
  has_many :units, :order => "position ASC", :autosave => true
  alias :children :units
  has_many :drills, :through => :units
  accepts_nested_attributes_for :units, allow_destroy: true

end
