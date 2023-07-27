class AddSubjectRefToClassMemberships < ActiveRecord::Migration[7.0]
  def change
    add_reference :class_memberships, :subject, null: false, foreign_key: true
  end
end
