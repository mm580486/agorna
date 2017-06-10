class Ticketmessage < ActiveRecord::Base
  belongs_to :ticket
#   mount_uploader :file, FileUploader # Tells rails to use this uploader for this model.
  after_create :broadcast

      private

      def broadcast
        ActionCable.server.broadcast('chat', as_json.merge(action: 'CreateMessage'))
      end
end
