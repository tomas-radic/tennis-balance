class CreateMatchToParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :match_to_participants do |t|
      t.integer :match_id,          null: false
      t.integer :order_nr,          null: false
      t.integer :participant_id,    null: false
      t.string  :participant_type,  null: false
      t.integer :meaning,           null: false, default: 0

      t.timestamps
    end
  end
end
