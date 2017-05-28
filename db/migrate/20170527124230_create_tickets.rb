class CreateTickets < ActiveRecord::Migration
  def up
    create_table :tickets do |t|
      t.string :title
      t.integer :user_id
      t.integer :user_two
      t.integer :status

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :tickets
  end
end
