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
  
  #EXPERIMENTAL
#  has_many :courses, :through => :matriculations
#  has_many :units, :through => :matriculations
#  has_many :drills, :through => :matriculations
#  has_many :drills, :through => :attempts
#  has_many :attempts, :through => :assessments
  
  has_many :attempts
  has_many :drills, :through => :attempts

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :role, :password, :password_confirmation, :remember_me
  ROLES = %w[admin instructor creator student]

  validates :role, :inclusion => { :in => ROLES,
    :message => "\"%{value}\" is not a valid role" }
end
