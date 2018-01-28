class CreateSeasons < ActiveRecord::Migration[5.1]
  def change
    create_table :seasons do |t|
      t.string :name
      t.date :date_ended
      t.integer :user_id

      t.timestamps
    end
  end
end
