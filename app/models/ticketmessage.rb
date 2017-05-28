class Ticketmessage < ActiveRecord::Base
  belongs_to :ticket
#   mount_uploader :file, FileUploader # Tells rails to use this uploader for this model.

end
