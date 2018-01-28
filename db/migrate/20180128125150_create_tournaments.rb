class CreateTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :date_open
      t.date :date_finals
      t.integer :season_id
      t.integer :user_id

      t.timestamps
    end
  end
end
