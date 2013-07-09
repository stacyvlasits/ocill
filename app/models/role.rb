class Role < ActiveRecord::Base
  attr_accessible :name, :user, :course
  belongs_to :user
  belongs_to :course

  ROLES = %w[Administrator Instructor Learner]


  validates :name, :inclusion => { :in => ROLES,
    :message => "\"%{value}\" is not a valid role. Select from #{Role::ROLES.join(", ")}." }
end
