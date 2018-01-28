class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :birth_year
      t.string :phone_number
      t.integer :user_id

      t.timestamps
    end
  end
end
