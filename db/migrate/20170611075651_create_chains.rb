class CreateChains < ActiveRecord::Migration
  def change
    create_table :chains do |t|
      t.integer :user_id
      t.integer :user_two
      t.boolean :accept

      t.timestamps null: false
    end
  end
end
