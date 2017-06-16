class Setting < ActiveRecord::Base
  mount_uploaders :mobile_slider, SettingUploader
  serialize :mobile_slider, JSON
  
  mount_uploaders :site_slider, SettingUploader
  serialize :site_slider, JSON
  
   mount_uploader :site_logo, SettingUploader
   mount_uploader :default_image_product, SettingUploader
   mount_uploader :default_image_exposition, SettingUploader
  
  
  
end
