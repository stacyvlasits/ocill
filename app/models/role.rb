class Role < ActiveRecord::Base
  attr_accessible :name, :user, :course
  belongs_to :user
  belongs_to :course

  scope :is_instructor_or_admin, ->(user) { where(:name => ['Instructor', 'Administrator'], :user_id => user.id )}
  scope :is_learner, ->(user) { where(:name => ['Learner'], :user_id => user.id )}

  ROLES = %w[Administrator Instructor Learner]


  validates :name, :inclusion => { :in => ROLES,
    :message => "\"%{value}\" is not a valid role. Select from #{Role::ROLES.join(", ")}." }
end
