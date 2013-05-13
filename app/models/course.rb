class Course < ActiveRecord::Base
  attr_accessible :position, :title, :lessons_attributes
  has_many :lessons, :order => "position ASC", :autosave => true
  alias :children :lessons
  has_many :drills, :through => :lessons
  accepts_nested_attributes_for :lessons, allow_destroy: true

end
