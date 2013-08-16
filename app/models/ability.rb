class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case user.role

    when "Administrator"
      can :manage, :all
    when "Instructor"
      can :manage, Course do |course|
        course.roles.is_instructor_or_admin(user).count > 0
      end
      can :create, Course
      can :manage, Unit do |unit|
        unit.course.roles.is_instructor_or_admin(user).count > 0
      end
      can :create, Unit
      can :manage, Drill do |drill|
        drill.course.roles.is_instructor_or_admin(user).count > 0
      end
      can :create, Drill
      can :manage, Attempt  # for debugging purposes only.
      can :read, Course, Unit, Drill
    when "Learner"
      can :read, Course do |course|
        course.roles.is_learner(user).count > 0
      end
      can :read, Unit do |unit|
        unit.course.roles.is_learner(user).count > 0
      end
      can :read, Drill do |drill|
        drill.course.roles.is_learner(user).count > 0
      end
      can :manage, Attempt do |attempt|
        attempt.course.is_learner(user).count > 0
      end
      can :create, Response do |response|
        response.attempt.users.include? user
      end
    end
    #everybody!
    can :read, Course
  end
end