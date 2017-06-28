class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :product_type
  has_many :favorites, :dependent => :destroy
  has_many :comments,:dependent => :destroy,:foreign_key=>'product_id'
  validates_presence_of :category_id
  validates_presence_of :detail
  mount_uploaders :images, ProductUploader
  serialize :images, JSON
  serialize :properties, Hash
end