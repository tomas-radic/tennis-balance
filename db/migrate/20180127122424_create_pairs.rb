class CreatePairs < ActiveRecord::Migration[5.1]
  def change
    create_table :pairs do |t| # refers to two players playing double together as a pair
      t.integer :user_id

      t.timestamps
    end
  end
end
