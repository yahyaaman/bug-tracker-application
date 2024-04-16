# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project 
    can :read, Bug 
    # can :create, Bug

    # can :create, :all if user.manager?
    # can :update, :all if user.manager?
    # can :destroy, :all if user.manager?

    can :create, Project if user.manager?
    can :update, Project if user.manager?
    can :destroy, Project if user.manager?
    
    can :create, Bug if user.qa?
    # can :update, Bug if user.qa?
    can :destroy, Bug if user.qa?

    can :update, Bug if user.developer?
    
    cannot :update, Project if user.developer?
    cannot :destroy, Project if user.developer?

    cannot :update, Project if user.qa?
    cannot :destroy, Project if user.qa?
  end
end
