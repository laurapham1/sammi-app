class AddUserRefToClassMemberships < ActiveRecord::Migration[7.0]
  def change
    add_reference :class_memberships, :user, null: false, foreign_key: true
  end
end
