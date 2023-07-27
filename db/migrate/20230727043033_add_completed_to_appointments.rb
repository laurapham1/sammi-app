class AddCompletedToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :completed, :boolean
  end
end
