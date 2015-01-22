class Ability
  include CanCan::Ability


  def initialize(user)
    user ||= User.new
    permissions = user.course_permissions
    
    case user.role

    when "Administrator"
      can :manage, :all
    when "Instructor"
      can :create, Section      
      can :manage, Course do |course|
        role = permissions.courses[course.id]
        role == "Instructor" || role == "Administrator"
      end
      can :create, Course
      can :manage, Unit do |unit|
        role = permissions.units[unit.id]
        role == "Instructor" || role == "Administrator"
      end
      can :create, Unit
      can :manage, Drill do |drill|
        role = permissions.drills[drill.id]
        role == "Instructor" || role == "Administrator"
      end
      can :create, Drill
      can :manage, Exercise do |exercise|
        role = permissions.drills[exercise.drill_id]
        role == "Instructor" || role == "Administrator"
      end
      can :create, Exercise      
      can :manage, ExerciseItem do |exercise_item|
        exercise_item.drill.course.roles.is_instructor_or_admin(user).count > 0
      end
      can :create, ExerciseItem      
      can :manage, Attempt  # for debugging purposes only.
      can :manage, Activity
      can :read, Course
      can :read, Unit
      can :read, Drill
      can :read, User
      can :read_more, :home
    when "Learner"
      can :read, User do |other_user|
        other_user.role != "Learner" || other_user == user
      end
      can :read, Course do |course|
        role = permissions.courses[course.id]
        role == "Learner" || role == "Instructor" || role == "Administrator"
      end
      can :read, Unit do |unit|
        role = permissions.units[unit.id]
        role == "Learner" || role == "Instructor" || role == "Administrator"
      end
      can :read, Drill do |drill|
        role = permissions.drills[drill.id]
        role == "Learner" || role == "Instructor" || role == "Administrator"
      end
      can :manage, Attempt do |attempt|
        role = permissions.drills[attempt.drill_id]
        role == "Learner" || role == "Instructor" || role == "Administrator"
      end
      can :manage, Attempt #for debugging only
      can :create, Attempt
      can :create, Response do |response|
        response.attempt.users.include? user
      end
      can :read_more, :home
    end
    #everybody!
    can :read, :home
  end
end