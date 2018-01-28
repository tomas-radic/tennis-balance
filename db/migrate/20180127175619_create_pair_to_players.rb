class CreatePairToPlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :pair_to_players do |t|
      t.integer :pair_id
      t.integer :player_id

      t.timestamps
    end
  end
end
