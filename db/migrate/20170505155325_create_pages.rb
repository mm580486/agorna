class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :layout,default: true
      t.string :title
      t.string :permalink
      t.integer :viewer
      t.text :content
      t.string :tags
      t.boolean :comment,default: false
      t.timestamps null: false
    end
  end
end
