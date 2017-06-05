require 'mini_magick'
class Product < ActiveRecord::Base
  after_save :set_watermark
  belongs_to :user
  belongs_to :product_type
  has_many :favorites, :dependent => :destroy
  has_many :comments,:dependent => :destroy,:foreign_key=>'product_id'
  mount_uploaders :images, ProductUploader
  serialize :images, JSON
  serialize :properties, Hash
  
  
  def set_watermark
    self.images.each do |image|
    img = MiniMagick::Image.from_file(image.path)

img.combine_options do |c|
  c.gravity 'SouthWest'
  c.draw "image Over 0,0 0,0 '#{Rails.root}/public/images/watermark.png'"
end

img.write(image.path)
    
  end
  
end
  
  
end

