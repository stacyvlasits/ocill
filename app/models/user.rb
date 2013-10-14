class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles, :dependent => :destroy
  has_many :courses, :through => :roles
  has_many :attempts
  has_many :drills, :through => :attempts

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :role, :password, :password_confirmation, :remember_me
  scope :none, where(:id => nil).where("id IS NOT ?", nil)
  default_scope order("last_name asc, first_name asc, email asc")

  validates :role, :inclusion => { :in => Role::ROLES,
    :message => "\"%{value}\" is not a valid role. Select from #{Role::ROLES.join(", ")}." }
  after_commit :flush_navigation_cache, :flush_permissions_cache

  def full_name
    self.first_name.to_s + " " + self.last_name.to_s
  end

  def is_admin?
    self.role == "Administrator"
  end

  def flush_navigation_cache
    Rails.cache.delete([self, "navigation-layout"])
  end
  
  def self.flush_all_navigation_caches
    self.all.each{|u| u.flush_navigation_cache}
  end
  
  #  TODO remove this method, I don't think it's used
  def flush_permissions_cache
    Rails.cache.delete([self, "permissions"])
  end

  def self.find_by_email_or_eid(info)
    info.downcase!
    if info.match(/[a-z]+[0-9]+$/)
      user = User.where("eid = ?", info)
    elsif info.match(/[a-z0-9\+\.]+\@[a-z0-9\+\.]+\.[a-z]{1,5}/) 
      user = User.where("email = ?", info)
    end
    user ||= User.none
  end

  # TODO: Make it possible to autogenerate an account using just the eid
  # TODO: add more error checking
  def self.find_or_create_by_email(email, role, creator)
    email.downcase!
    if email.match(/[a-z0-9\+\.]+\@[a-z0-9\+\.]+\.[a-z]{1,5}/) 
      user = User.where("email = ?", email)
      new_user = User.create_and_notify(email, role, creator) if user.empty?
      user ||= new_user
    end 
    user ||= User.none
  end

  def self.create_and_notify(email, role, creator= "Someone")
    password = User.reset_password_token
    role = ( role == "Instructor" || role == "Administrator" ) ? "Instructor" : "Learner"
    user = self.new(email: email, role: role, password: password)
    user.reset_password_token = User.reset_password_token
    user.reset_password_sent_at = Time.now
    user.save
    NewRegistration.welcome_email(user, role, creator).deliver if user.id
  end

  def senior_role(course)
    all_roles = self.roles.where(:course_id => course.id).map {|r| r.name }
    if all_roles.include? "Administrator"
      "Administrator"
    elsif all_roles.include? "Instructor"
      "Instructor"
    elsif all_roles.include? "Learner"
      "Learner"
    else
      ""
    end
  end
  
  def cached_course_permissions
    CoursePermissions
    Unit
    Rails.cache.fetch([self, "permissions"]) do
      course_permissions
    end
  end

  def course_permissions
    perm = CoursePermissions.new(self)
    perm.build!
    perm
  end

  def attempts_on(drill)
    self.attempts.where(:drill_id => drill.id)
  end

  def total_attempts(drill)
    attempts_on(drill).size
  end
  
  def best_attempt(drill)
    attempts_on(drill).max{|a, b| a.correct <=> b.correct}
  end
  
  def worst_attempt(drill)
    attempts_on(drill).min{|a, b| a.correct <=> b.correct}
  end
  def total_score(drill)
    attempts_on(drill).includes(:responses).inject(0) {|sum, attempt| sum + attempt.correct}
  end
  def total_responses(drill)
    attempts_on(drill).inject(0) {|sum, attempt| sum + attempt.total}
  end

  def average_score(drill)
    attempts = total_attempts(drill)
    score = total_score(drill)
    if attempts == 0
      "--" # this should never happen
    elsif score == 0
      0.0
    else
      (score.to_f/attempts).round(2)
    end
  end
end
