json.products @products do |product|
  json.id product.id
  json.name product.name
  json.poster product.images[0].url
  
end