class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.references :seller, index: true, foreign_key: true
      t.string :body
      t.boolean :accept,default: false
      t.boolean :accept_by_seller,default: false

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :comments
  end
end
