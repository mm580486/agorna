json.tickets @tickets do |ticket|
  json.id ticket.id
  json.title ticket.title
  json.from (ticket.user_id == @user.id)? User.find(ticket.user_two).name : User.find(ticket.user_id).name
  json.avatar "https:pinsood.com#{(ticket.user_id == @user.id)? User.find(ticket.user_two).avatar_url : User.find(ticket.user_id).avatar_url}"
end