json.comments @comments do |comment|
  json.id comment.id
  json.body comment.body
  json.username comment.user.name

end