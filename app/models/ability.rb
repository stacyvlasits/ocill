class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case user.role
    when "admin"
      can :manage, :all
    when "instructor"
      can :read, :all
      can :create, Course
      can :update, Course do |course|
        course.try(:user) == user
      end
      can :create, Drill
      can :update, Drill do |drill|
        drill.course.try(:user) == user
      end
      can :read, Attempt do |attempt|
        attempt.course.try(:user) == user
      end
    when "student"
      can :read, Course
      can :read, Drill do |drill|
        drill.course.try(:user) == user
      end
      can :create, Attempt do |attempt|
        attempt.try(:user) == user
      end
    end
  end
end