json.comments @comments do |comment|
  json.id comment.id
  json.body comment.body
  json.username comment.user.name
  json.avatar comment.user.avatar_url
  json.time_ago_in_words time_ago_in_words(comment.created_at)
end