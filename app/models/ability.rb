# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.creator?
      can :read, Asset
      can :bulk_import, Asset
    end
  
    if user.customer?
      can :read, Asset
      can :read, Purchase
      can :create, Purchase
      can :shop, Purchase
    end

    if user.admin?
      can :read, :admin_earnings
    end
  end
end
