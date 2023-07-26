class CreateClassMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :class_memberships do |t|

      t.timestamps
    end
  end
end
