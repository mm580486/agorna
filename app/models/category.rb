class Category < ActiveRecord::Base
  belongs_to :user,required: true
  has_many :users, :class_name => "User", :foreign_key => "category_id", :dependent => :destroy
  has_many :products, :class_name => "Product", :foreign_key => "category_id", :dependent => :destroy
  mount_uploader :image, AvatarUploader
  validates_presence_of :name
  validates_length_of :name, :minimum => 2, :maximum => 255
  validates_presence_of :permalink
  validates_length_of :permalink, :minimum => 3, :maximum => 255
  validates_uniqueness_of :permalink
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category", :dependent => :destroy
  # has_many :products, :dependent => :destroy
  accepts_nested_attributes_for :subcategories, allow_destroy: true

end
