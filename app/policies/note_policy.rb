class NotePolicy < ApplicationPolicy
  def create?
    user&.role === 'teacher'
  end

  def destroy?
    record.teacher == user
  end
end
