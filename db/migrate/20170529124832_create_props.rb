class CreateProps < ActiveRecord::Migration
  def up
    create_table :props do |t|
      t.string :name
      t.integer :product_field_id
      t.string :permalink
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :props
  end
end
