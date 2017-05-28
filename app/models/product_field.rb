class ProductField < ActiveRecord::Base
  belongs_to :product_type,required: true
  acts_as_list scope: :product_type_id,top_of_list: 0
end
