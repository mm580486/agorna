class CreateSettings < ActiveRecord::Migration
  def up
    create_table :settings do |t|
      t.string :site_name,null: false,default: 'Agorna'
      t.string :seo_description,null: false
      t.string :site_logo
      t.string :default_image_product
      t.string :default_image_exposition
      t.string :mobile_slider
      t.string :site_slider

      t.boolean :site_down,default: false

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :settings
    
  end
end
