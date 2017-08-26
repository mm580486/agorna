class AddSomeFieldsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :date, :string
    add_column :users, :national_card_image, :string
    add_column :users, :business_license_image, :string
    add_column :users, :family, :string
  end
end
