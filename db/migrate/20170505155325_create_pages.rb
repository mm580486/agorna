class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :layout,default: true
      t.string :title
      t.string :permalink
      t.integer :viewer
      t.text :content
      t.string :tags
      t.boolean :comment,default: false
      t.boolean :lock,default: true
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :pages
  end
  
end
