class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.string :permalink

      t.timestamps null: false
    end
  end
end
