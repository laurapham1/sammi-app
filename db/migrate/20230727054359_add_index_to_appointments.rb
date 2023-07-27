class AddIndexToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_index :appointments, [:student_id, :teacher_id]
  end
end
