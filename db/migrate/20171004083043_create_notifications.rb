class CreateNotifications < ActiveRecord::Migration
  def up
    create_table :notifications do |t|
      t.integer :user_id,null: false
      t.integer :type,null: false,default: 0
      t.string :body,null: false
      t.boolean :seen,default: false

      t.timestamps null: false
    end
  end

  def down
    drop_table :notifications
  end
end
