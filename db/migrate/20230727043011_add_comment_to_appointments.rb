class AddCommentToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :comment, :string
  end
end
