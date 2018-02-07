class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.date :date_played
      t.string :place
      t.string :surface
      t.integer :environment
      t.integer :tournament_id
      t.integer :season_id
      t.integer :user_id
      t.integer :max_game_sets, null: false, default: 3
      t.integer :retired_participant_order_nr # if nil: no retire, if 0: first participant retired, if 1: second participant retired
      t.integer :winning_participant_order_nr # if nil: no winner, if 0: first participant won, if 1: second participant won
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
  end
end
