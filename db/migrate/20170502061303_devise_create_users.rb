class DeviseCreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: true, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      
      
      t.integer :marketer_id
      
      # level 0 visitor
      # level 1 seller
      # level 2 add-seller
      # level 3 admin
      t.integer  :level, default: 0, null: false
      t.string  :name, null: false
      t.string  :phone
      # Exposition detail
      t.boolean :exposition,default: false
      t.string :exposition_name
      t.string :identify,default: nil
      t.string :exposition_address
      t.string :exposition_detail
      t.integer :category_id,default: nil
      t.string :static_phone
      t.string :avatar
      t.string :background_image
      t.string :instagram_id
      t.string :telegram
      t.boolean :post_service , default: false
      t.boolean :exposition_accept,default: false
      t.float :longitude,default: nil
      t.float :latitude,default: nil
      
      t.boolean :phone_verify,default: false
      t.boolean :email_verify,default: false
      t.integer :verify_code,default: 0
      
      # marketers
      
      t.string :national_code, default: ''

      
      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
      t.string :authentication_token, null: false

      t.timestamps null: false
    end

    add_index :users, :email
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    add_index :users, :authentication_token, unique: true
  end
  
  
  def down
    
    drop_table :users
  end
end
