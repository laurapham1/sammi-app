class AddEmotionRefToDailyEmotions < ActiveRecord::Migration[7.0]
  def change
    add_reference :daily_emotions, :emotion, null: false, foreign_key: true
  end
end
