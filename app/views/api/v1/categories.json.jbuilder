json.categories @categories do |category|
  json.id category.id
  json.name category.name
  json.subcategories category.subcategories
end