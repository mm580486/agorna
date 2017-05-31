json.products @products do |product|
  json.id product.id
  json.name product.name
  json.poster "https://www.pinsood.com#{product.images[0].url}"
  json.price product.price.scan(/.{3}/).join(',')
  json.off_price product.off_price.scan(/.{3}/).join(',')
  json.has_offer_price (!product.off_price.nil? || !product.off_price.blank?)
end