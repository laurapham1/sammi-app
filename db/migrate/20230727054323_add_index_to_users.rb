class AddIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :notes, [:student_id, :teacher_id]
  end
end
