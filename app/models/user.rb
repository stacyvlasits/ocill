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

  has_many :roles
  has_many :courses, :through => :roles
  has_many :attempts
  has_many :drills, :through => :attempts

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :role, :password, :password_confirmation, :remember_me

  scope :none, where(:id => nil).where("id IS NOT ?", nil)

  validates :role, :inclusion => { :in => Role::ROLES,
    :message => "\"%{value}\" is not a valid role. Select from #{Role::ROLES.join(", ")}." }

  def self.find_by_email_or_eid(info)
    if info.match(/[a-z]+[0-9]+/)
      user = User.where("eid = ?", info)
    elsif info.match(/[a-z0-9\+\.]+\@[a-z0-9\+\.]+\.[a-z]{1,5}/)
      user = User.where("email = ?", info)
    end
    user ||= User.none
  end
end
