class AddNameToSubjects < ActiveRecord::Migration[7.0]
  def change
    add_column :subjects, :name, :string
  end
end
