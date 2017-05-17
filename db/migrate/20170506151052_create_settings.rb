class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :site_name,null: false,default: 'Agorna'
      t.string :seo_description,null: false
      t.string :seo_keywords,null: false
      t.string :site_logo
      t.string :default_image_product
      t.string :default_image_exposition
      t.text :style
      t.text :javascript
      t.boolean :site_down,default: false

      t.timestamps null: false
    end
  end
end
