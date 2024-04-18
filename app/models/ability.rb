# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(account)
    cannot :manage, :all

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
      can :read, Region
      can :read, District
      can :read, Award

      admin_memberships = account.memberships.where(role: 1)
      admin_departments = admin_memberships.map(&:fire_department)

      admin_memberships.each do |membership|
        can [:read, :update], Account, memberships: { fire_department: membership.fire_department }
      end

      can :manage, Membership, fire_department: { id: admin_departments.map(&:id) }
      can :create, Membership
    end
    end
  end
end