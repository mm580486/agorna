class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name,null: false
      t.string :price
      t.string :off_price
      t.integer :position
      t.boolean :comment,default: true
      t.integer :view_product,default: 0
      t.references :product_type, index: true, foreign_key: true
      t.text :properties

      t.timestamps null: false
    end
  end
end
