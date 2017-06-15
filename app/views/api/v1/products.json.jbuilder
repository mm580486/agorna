json.products @products do |product|
  json.id product.id
  json.name product.name
  json.exposition_name product.user.name
  json.exposition_id product.user.id
  json.avatar product.user.avatar_url.nil? ? "http://pinsood.com#{@setting.default_image_exposition}" : "https://www.pinsood.com#{product.user.avatar_url}" 
  json.poster "https://www.pinsood.com#{product.images[0].url rescue "http://pinsood.com#{@setting.default_image_product}" }"
  json.price product.price.scan(/.{3}/).join(',')
  json.off_price product.off_price.scan(/.{3}/).join(',')
  json.has_offer_price !product.off_price.blank?
end