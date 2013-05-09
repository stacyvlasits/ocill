class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :roles
  
  #EXPERIMENTAL
#  has_many :courses, :through => :matriculations
#  has_many :lessons, :through => :matriculations
#  has_many :drills, :through => :matriculations
#  has_many :drills, :through => :attempts
#  has_many :attempts, :through => :assessments

  has_many :roles
  has_many :attempts
  has_many :drills, :through => :attempts

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
