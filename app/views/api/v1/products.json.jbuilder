json.products @products do |product|
  json.id product.id
  json.name product.name
  json.exposition_name product.user.name
  json.exposition_id product.user.id
  json.avatar product.user.avatar_url.nil? ? "http://pinsood.com#{@setting.default_image_exposition}" : "https://www.pinsood.com#{product.user.avatar_url}" 
  json.poster "https://www.pinsood.com#{product.images[0].url rescue "#{@setting.default_image_product}" }"
  begin
  json.price product.price.scan(/.{3}/).join(',')
  json.off_price product.off_price.scan(/.{3}/).join(',')
rescue
  json.price product.price
  json.off_price product.off_price
end
  json.has_offer_price !product.off_price.blank?
  if @user
  json.favorited @user.favorites.exists?(product_id: product.id)
  end
end