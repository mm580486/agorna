class ProductType < ActiveRecord::Base
  validates_uniqueness_of :permalink , message: 'قبلا با این نام ثبت شده است !'
  has_many :fields, class_name: "ProductField",dependent: :destroy
  accepts_nested_attributes_for :fields, allow_destroy: true


end
