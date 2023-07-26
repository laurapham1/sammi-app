class EmotionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    new?
  end

  def new?
    record.user == user
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end
end
