class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :product_type
  has_many :favorites, :dependent => :destroy
  mount_uploaders :images, ProductUploader
serialize :images, JSON
end
