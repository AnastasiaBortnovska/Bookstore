# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can %i[show update destroy], User, id: user.id
      can %i[create update], Address, addressable_id: user.id, addressable_type: 'User'
    end

    can %i[index show], Book
  end
end
