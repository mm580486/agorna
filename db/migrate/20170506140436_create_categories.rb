class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name,null: false
      t.string :permalink,null: false
      t.integer :parent_id,default: nil

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :categories
  end
end
