class CreateGameSets < ActiveRecord::Migration[5.1]
  def change
    create_table :game_sets do |t|
      t.integer :match_id
      t.integer :sequence_nr,   null: false # if 1: first set, if 2: second set, ...
      t.string :games # two elements array: number of games won [first_participant, second_participant]
      t.string :tiebreak # two elements array: number of points won [first_participant, second_participant]
      t.string :supertiebreak # two elements array: number of points won [first_participant, second_participant]

      t.timestamps
    end
  end
end
