class NotePolicy < ApplicationPolicy
  def create?
    user&.teacher
  end

  def destroy?
    record.teacher == user
  end
end
