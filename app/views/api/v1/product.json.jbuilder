  json.id @product.id
  json.name @product.name
  json.images @product.images.map {|image| "https://www.pinsood.com#{image.url}" }
  begin
  json.price @product.price.scan(/.{3}/).join(',')
  json.off_price @product.off_price.scan(/.{3}/).join(',')
rescue
  json.price @product.price
  json.off_price @product.off_price
end
  json.has_offer_price !@product.off_price.blank?
  json.exposition_name @product.user.exposition_name
  json.exposition_id @product.user.id
  json.avatar "https://www.pinsood.com#{@product.user.avatar.url}"
  json.detail @product.detail
  json.category Category.find(@product.category_id).name
  json.dynamic_fields @product.properties.map {|key,value| "#{key}:#{value}"}
  if @user
  json.favorited @user.favorites.exists?(product_id: @product.id)
  end