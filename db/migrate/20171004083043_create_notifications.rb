class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :type
      t.string :body
      t.boolean :seen

      t.timestamps null: false
    end
  end
end
