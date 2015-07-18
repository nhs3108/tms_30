class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :show, Course do |course|
        course.has_member? user
      end
      can :manage, Course do |course|
        course.has_supervisor? user      
      end
    end
  end
end
