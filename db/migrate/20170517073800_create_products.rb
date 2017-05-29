class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name,null: false
      t.integer :category_id
      t.string :price
      t.string :off_price
      t.integer :position
      t.boolean :comment,default: true
      t.boolean :accept,default: false
      t.integer :view_product,default: 0
      t.references :product_type, index: true, foreign_key: true
      t.text :properties, :hstore, default: {}
      t.column  :images, :string
      t.string :detail 
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :products
  end
end
