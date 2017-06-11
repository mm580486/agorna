class ProductField < ActiveRecord::Base
  belongs_to :product_type,required: true
  acts_as_list scope: :product_type_id,top_of_list: 0
  has_many :props
  validates_uniqueness_of :permalink , message: 'قبلا با این نام ثبت شده است !',scope: :product_type_id
end
