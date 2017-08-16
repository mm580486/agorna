class CreateMarketerTasks < ActiveRecord::Migration
  def change
    create_table :marketer_tasks do |t|
      t.integer :user_id
      t.integer :user_two
      t.string :message

      t.timestamps null: false
    end
  end
end
