class CreateDailyEmotions < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_emotions do |t|

      t.timestamps
    end
  end
end
