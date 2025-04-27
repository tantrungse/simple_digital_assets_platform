# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    return unless user.creator?
    can :read, Asset
    can :bulk_import, Asset
  end
end
