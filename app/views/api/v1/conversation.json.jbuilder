json.conversations @ticketmessages do |message|
  json.id message.id
  json.message message.message.gsub(/\S*$(\[[^\]]+\]|\S+)/, '[\1]')
  json.user_id message.user_id
  json.time message.created_at
end
if action_name == 'conversation'
  json.opponent_name @opponent.name
  json.opponent_id @opponent.id
end