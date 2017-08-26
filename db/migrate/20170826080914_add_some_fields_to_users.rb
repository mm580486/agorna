class AddSomeFieldsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :date, :string
    add_column :users, :national_card_image, :string
    add_column :users, :business_license_image, :string
    add_column :users, :family, :string
    add_column :users, :gender, :string
  end
  
  def down
    remove_column :users, :date, :string
    remove_column :users, :national_card_image, :string
    remove_column :users, :business_license_image, :string
    remove_column :users, :family, :string
    remove_column :users, :gender, :string
  end

end
