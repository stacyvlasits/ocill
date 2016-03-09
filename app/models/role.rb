class Role < ActiveRecord::Base
  belongs_to :user, :touch => true
  belongs_to :course

  scope :is_instructor_or_admin, ->(user) { where(:name => ['Instructor', 'Administrator'], :user_id => user.id )}
  scope :is_learner, ->(user) { where(:name => ['Learner'], :user_id => user.id )}
  scope :in_course, ->(course) { where(:course_id => course.id)}
  scope :highest, ->(user) { where(:user_id => user.id).order("name ASC").limit(1)}

  after_create :check_and_update_user_role

  # TODO if this list ever changes, you will need to redefine scope :highest to not be stupid
  ROLES = %w[Administrator Instructor Learner]


  validates :name, :inclusion => { :in => ROLES,
    :message => "\"%{value}\" is not a valid role. Select from #{Role::ROLES.join(", ")}." }
  validates :user_id, :presence => true
  validates :course_id, :presence => true

  def check_and_update_user_role
    if self.user.role == "Learner"
      if self.user.senior_role(self.course) == "Administrator" || self.user.senior_role(self.course) == "Instructor"
        self.user.role = "Instructor"
        self.user.save!
        self.user
      end
    end
  end  

end
