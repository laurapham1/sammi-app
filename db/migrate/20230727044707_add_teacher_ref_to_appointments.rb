class AddTeacherRefToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments, :teacher, null: false, foreign_key: { to_table: :users }
  end
end
