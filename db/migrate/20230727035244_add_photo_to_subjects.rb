class AddPhotoToSubjects < ActiveRecord::Migration[7.0]
  def change
    add_column :subjects, :photo, :string
  end
end
