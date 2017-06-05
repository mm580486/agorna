
class Product < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :product_type
  has_many :favorites, :dependent => :destroy
  has_many :comments,:dependent => :destroy,:foreign_key=>'product_id'
  mount_uploaders :images, ProductUploader
  serialize :images, JSON
  serialize :properties, Hash
  
  
  
  
  
end

