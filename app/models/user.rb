class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
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
  attr_accessible :email, :role, :password, :password_confirmation, :remember_me

  scope :none, where(:id => nil).where("id IS NOT ?", nil)

  validates :role, :inclusion => { :in => Role::ROLES,
    :message => "\"%{value}\" is not a valid role. Select from #{Role::ROLES.join(", ")}." }

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
    user = self.new(email: email, role: role, password: password)
    user.reset_password_token = User.reset_password_token
    user.reset_password_sent_at = Time.now
    user.save
    NewRegistration.welcome_email(user, role, creator).deliver if user.id 
  end
end
