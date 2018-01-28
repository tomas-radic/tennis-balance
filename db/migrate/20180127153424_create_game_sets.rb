class CreateGameSets < ActiveRecord::Migration[5.1]
  def change
    create_table :game_sets do |t|
      t.integer :match_id
      t.integer :sequence_nr,   null: false
      t.string :games
      t.string :tiebreak
      t.string :supertiebreak

      t.timestamps
    end
  end
end
