class AddSomeFieldsToUsers < ActiveRecord::Migration
  def up
    add_column :user, :date, :string
    add_column :user, :national_card_image, :string
    add_column :user, :business_license_image, :string
    add_column :user, :family, :string
  end
end
