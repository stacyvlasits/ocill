class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case user.role

    when "Administrator"
      can :manage, :all
    when "Instructor"
      can :manage, Course do |course|
        course.roles.where(:name => ['Instructor', 'Administrator'], :user_id => user.id ).count > 0
      end
      can :create, Course
      can :read, Course
      can :manage, Unit do |unit|
        unit.course.roles.where(:name => ['Instructor', 'Administrator'], :user_id => user.id ).count > 0
      end
      can :create, Unit
      can :manage, Drill do |drill|
        drill.course.roles.where(:name => ['Instructor', 'Administrator'], :user_id => user.id ).count > 0
      end
      can :create, Drill
      can :manage, Attempt  # for debugging purposes only.
    when "Learner"
      can :read, Course do |course|
        course.roles.where(:name => ['Learner'], :user_id => user.id ).count > 0
      end
      can :read, Drill do |drill|
        drill.course.roles.where(:name => ['Learner'], :user_id => user.id ).count > 0
      end
      can :create, Attempt do |attempt|
        attempt.drill.course.roles.where(:name => ['Learner'], :user_id => user.id ).count > 0
      end
      can :create, Response do |response|
        response.attempt.users.include? user
      end
    end
    #everybody!
    can :read, Course
    can :create, :read, Attempt  #TODO fix
  end
end