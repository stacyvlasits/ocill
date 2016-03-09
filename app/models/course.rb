class Course < ActiveRecord::Base
  has_many :activities
  has_many :units, -> {order 'position ASC' }, :dependent => :destroy, :autosave => true
  alias :children :units
  has_many :drills, :through => :units
  accepts_nested_attributes_for :units, allow_destroy: true
  has_many :roles
  has_many :users, :through => :roles, :autosave => true

  validates :position, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :title, :presence => true

  after_initialize :set_default_position
  after_commit :flush_user_navigation_caches
  default_scope { order('title ASC') }

private
  def set_default_position
    self.position ||= Course.maximum(:id).to_i + 1
  end

  def self.cached_courses
    Unit
    FillDrill
    GridDrill
    Rails.cache.fetch(["courses"]) do
      Course.includes(:roles, :units => :drills).to_a
    end
  end

private
  def flush_user_navigation_caches
    User.flush_all_navigation_caches
  end
end
