class AddRatingToEmotions < ActiveRecord::Migration[7.0]
  def change
    add_column :emotions, :rating, :integer
  end
end
