json.conversations @ticketmessages do |message|
  json.id message.id
  json.message message.message
  json.user_id message.user_id
  
end