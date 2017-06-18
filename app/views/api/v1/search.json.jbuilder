unless @products.nil?
json.products @products do |product|
  json.id product.id
  json.name product.name
  json.exposition_name product.user.name
  json.exposition_id product.user.id
  json.avatar product.user.avatar_url.nil? ? "http://pinsood.com#{@setting.default_image_exposition}" : "https://www.pinsood.com#{product.user.avatar_url}" 
  json.poster "https://www.pinsood.com#{product.images[0].url rescue "#{@setting.default_image_product}" }"
  json.price product.price.scan(/.{3}/).join(',')
  json.off_price product.off_price.scan(/.{3}/).join(',')
  json.has_offer_price !product.off_price.blank?
end
else

json.expositions @expositions do |user|
  json.id user.id
  json.name user.name
  json.exposition_name user.exposition_name
  json.background user.background_image_url.nil? ? "http://pinsood.com#{Setting.first.default_image_exposition_url}" : "http://pinsood.com#{user.background_image_url}"
  json.avatar user.avatar_url.nil? ? Setting.first.default_image_exposition_url : "http://pinsood.com#{user.avatar_url}"
  json.static_phone user.static_phone
  json.instagram user.instagram_id
  json.telegram user.telegram
  json.exposition_details user.exposition_detail
  json.exposition_address user.exposition_address
  json.post_service user.post_service?
end

end