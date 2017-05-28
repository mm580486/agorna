class CreateTicketmessages < ActiveRecord::Migration
  def up
    create_table :ticketmessages do |t|
      t.text :message
      t.integer :ticket_id
      t.integer :user_id
      t.string :file
      t.boolean :seen,default: false
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :ticketmessages
  end
end
