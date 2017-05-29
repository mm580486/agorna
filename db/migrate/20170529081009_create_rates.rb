class CreateRates < ActiveRecord::Migration
  def up
    create_table :rates do |t|
      t.integer :user_id , null: false
      t.integer :exposition_id, null: false
      t.integer :vote
      t.timestamps null: false
    end
  end
  
  
  def down
    drop_table :rates
  end
end
