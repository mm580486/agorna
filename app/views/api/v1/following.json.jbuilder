json.expositions @users do |user|
  json.name user.name
  json.exposition_name user.exposition_name
  json.background user.background_image_url.nil? ? "undefined" : "http://pinsood.com#{user.background_image_url}"
  json.avatar user.avatar_url.nil? ? "http://pinsood.com#{Setting.first.default_image_exposition_url}" : "http://pinsood.com#{user.avatar_url}"
  json.static_phone user.static_phone
  json.instagram user.instagram_id
  json.telegram user.telegram
  json.exposition_details user.exposition_detail
  json.exposition_address user.exposition_address
  json.post_service user.post_service?
  json.followed user.followers.include? @user 
  
  
end