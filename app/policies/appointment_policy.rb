class AppointmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    create?
  end

  def create?
    user.teacher
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
