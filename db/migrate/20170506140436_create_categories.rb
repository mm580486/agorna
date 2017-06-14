class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name,null: false
      t.string :permalink,null: false
      t.string :image
      t.integer :parent_id,default: nil
      t.integer :product_type_id

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :categories
  end
end
