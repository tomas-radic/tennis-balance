class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.date :date_played
      t.string :place
      t.string :surface
      t.integer :tournament_id
      t.integer :season_id
      t.integer :user_id
      t.integer :max_game_sets, null: false, default: 3

      t.timestamps
    end
  end
end
