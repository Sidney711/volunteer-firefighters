# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(account)
    account ||= Account.new

    if account.is_super_admin?
      can :manage, FireDepartment
      can :manage, Region
      can :manage, District
      can :manage, Award
      can :manage, Membership
      can :manage, Account
    else if account.is_admin
      can :read, FireDepartment
      can :read, Account
      can :read, Region
      can :read, Membership
      can :read, District
      can :read, Award
    end
    end
    end
end
