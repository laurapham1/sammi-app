class AddUserRefToDailyEmotions < ActiveRecord::Migration[7.0]
  def change
    add_reference :daily_emotions, :user, null: false, foreign_key: true
  end
end
