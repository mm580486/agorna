class Favorite < ActiveRecord::Base
  belongs_to :user,class_name: 'User'
  belongs_to :product,class_name: 'Product'
end
