class Role < ActiveRecord::Base
  attr_accessible :name, :user, :course
  belongs_to :user
  belongs_to :course

  scope :is_instructor_or_admin, ->(user) { where(:name => ['Instructor', 'Administrator'], :user_id => user.id )}
  scope :is_learner, ->(user) { where(:name => ['Learner'], :user_id => user.id )}
  scope :in_course, ->(course) { where(:course_id => course.id)}
  scope :highest, ->(user) { where(:user_id => user.id).order("name ASC").limit(1)}

  # TODO if this list ever changes, you will need to redefine scope :highest to not be stupid
  ROLES = %w[Administrator Instructor Learner]


  validates :name, :inclusion => { :in => ROLES,
    :message => "\"%{value}\" is not a valid role. Select from #{Role::ROLES.join(", ")}." }
  validates :user_id, :presence => true
  validates :course_id, :presence => true

end
