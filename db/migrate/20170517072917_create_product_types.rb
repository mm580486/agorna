class CreateProductTypes < ActiveRecord::Migration
  def up
    create_table :product_types do |t|
      t.string :name
      t.string :permalink
      t.boolean :lock

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :product_types
  end
end
