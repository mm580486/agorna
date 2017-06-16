json.categories @categories do |category|
  json.name category.name
  json.permalink category.permalink
  json.id category.id
end


json.dynamic_filters @dynamic_filters do |filter|
  json.name filter.name
  json.permalink filter.permalink
  json.id filter.id
end