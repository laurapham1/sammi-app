class AddContentToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :content, :string
  end
end
