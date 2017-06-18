json.fields @fields do |field|
  json.name field.name
  json.required field.required
  json.permalink field.permalink
  json.field_type field.field_type
  json.props field.props.map { |v| v.name }
end