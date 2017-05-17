class CreateProductFields < ActiveRecord::Migration
  def change
    create_table :product_fields do |t|
      t.string :name,null: false
      t.boolean :required,default: false
      t.string :permalink,null: false
      t.integer :position,null: false
      t.belongs_to :product_type, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
