json.products @products do |product|
  json.id product.id
  json.name product.name
  json.exposition_name product.user.name
  json.avatar "https://www.pinsood.com#{product.user.avatar_url}"
  json.poster "https://www.pinsood.com#{product.images[0].url rescue 'https://unsplash.it/200/300/?random' }"
  json.price product.price.scan(/.{3}/).join(',')
  json.off_price product.off_price.scan(/.{3}/).join(',')
  json.has_offer_price !product.off_price.blank?
end