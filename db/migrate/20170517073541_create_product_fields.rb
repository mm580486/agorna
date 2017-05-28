class CreateProductFields < ActiveRecord::Migration
  def up
    create_table :product_fields do |t|
      t.string :name,null: false
      t.boolean :required,default: false
      t.string :permalink,null: false
      t.integer :position,null: false,default: false
      t.belongs_to :product_type, index: true, foreign_key: true
      t.string :field_type
      
      t.text :categories, array: true, default: []
      t.timestamps null: false
    end
  end
  
  def down
    
    drop_table :product_fields
  end
end
