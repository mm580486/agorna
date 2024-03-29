json.tickets @tickets do |ticket|
  json.id ticket.id
  json.title ticket.title
  json.from (ticket.user_id == @user.id)? User.find(ticket.user_two).name : User.find(ticket.user_id).name
  json.avatar "https:pinsood.com#{(ticket.user_id == @user.id)? User.find(ticket.user_two).avatar_url : User.find(ticket.user_id).avatar_url}"
  json.last_message ticket.ticketmessages.last.message
  json.new_messages_size ticket.ticketmessages.where(seen: false).size
  json.time_ago_in_words time_ago_in_words(ticket.ticketmessages.last.created_at)
end