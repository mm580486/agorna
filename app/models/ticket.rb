class Ticket < ActiveRecord::Base
  has_many :ticketmessages
  accepts_nested_attributes_for :ticketmessages, allow_destroy: true
end
