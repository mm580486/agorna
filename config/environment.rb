# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| 
  msg = instance.error_message 

  if html_tag =~ /<(input|textarea|select)[>]+class=/
    class_attribute = html_tag =~ /class=['"]/ 
    html_tag.insert(class_attribute + 7, "red-text ") 
  elsif html_tag =~ /<(input|textarea|select)/
    first_whitespace = html_tag =~ /\s/ 
    html_tag[first_whitespace] = " class='red-text' "
  end 

  html_tag
}