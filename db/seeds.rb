# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Setting.create({
    site_name: 'پین سود',
    seo_description: 'pinsood',
    
})

User.create(:name => 'محمد محمودی',
            :email => 'mm580486@gmail.com',
            :phone => '09127105568',
            :password => 'Microlab12546',
            :password_confirmation => 'Microlab12546',
            :level => 3
                 )

User.create(:name => 'علی شهبازی',
            :email => 'alireza.shahbaziy@gmail.com',
            :phone => '09382887628',
            :password => 'ali5371370',:password_confirmation => 'ali5371370',
            :level => 3)

User.create(:name => 'مهدی',
            :email => 'mehdi.rezaei2002@gmail.com',
            :phone => '09192190394',
            :password => 'ali5371370',:password_confirmation => 'ali5371370',
            :level => 3)

User.create(:name => 'علی میانجی',
            :email => 'ali_uls@gmail.com',
            :phone => '09196225068',
            :password => 'ali5371370',:password_confirmation => 'ali5371370',
            :level => 3)
            
User.create(:name => 'جواد',
            :email => 'jazz_blues@gmail.com',
            :phone => '0919000000',
            :password => 'ali5371370',:password_confirmation => 'ali5371370',
            :level => 3)
            
            
poshak_form=ProductType.create(
    :name => 'پوشاک',
    :permalink => 'poshak'
    )     
    
poshak=Category.create(
    :name      => 'پوشاک',
    :permalink => 'poshak-cat',
    :remote_image_url => 'http://loremflickr.com/320/240/electronic',
    :product_type_id => poshak_form.id,
    :user_id => 1
    )
    
    
Category.create(
    :name      => 'تی شرت',
    :permalink => 't-shirt',
    :parent_id => poshak.id,
    :remote_image_url => 'http://loremflickr.com/320/240/t-shirt',
    :user_id => 1
    )
    
Category.create(
    :name      => 'کفش',
    :permalink => 'shoes',
    :parent_id => poshak.id,
    :remote_image_url => 'http://loremflickr.com/320/240/shoes',
    :user_id => 1
    )
Category.create(
    :name      => 'سوتین',
    :permalink => 'sotiyan',
    :parent_id => poshak.id,
    :remote_image_url => 'http://loremflickr.com/320/240/boobs',
    :user_id => 1
    )   
    
Category.create(
    :name      => 'شلوار',
    :permalink => 'shalvar',
    :parent_id => poshak.id,
    :remote_image_url => 'http://loremflickr.com/320/240/pants',
    :user_id => 1
    )
    
    
    electronic_form=ProductType.create(
    :name => 'الکترونیک',
    :permalink => 'electronic_form'
    )     
    
electronic=Category.create(
    :name      => 'الکترونیک',
    :permalink => 'electronic',
    :remote_image_url => 'http://loremflickr.com/320/240/electronic',
    :product_type_id => electronic_form.id,
    :user_id => 1
    )
Category.create(
    :name      => 'موبایل',
    :permalink => 'mobile',
    :parent_id => electronic.id,
    :remote_image_url => 'http://loremflickr.com/320/240/mobile',
    :user_id => 1
    )
Category.create(
    :name      => 'تبلت',
    :permalink => 'tablet',
    :parent_id => electronic.id,
    :remote_image_url => 'http://loremflickr.com/320/240/tablet',
    :user_id => 1
    )
Category.create(
    :name      => 'مک بوک',
    :permalink => 'macbook',
    :parent_id => electronic.id,
    :remote_image_url => 'http://loremflickr.com/320/240/macbook',
    :user_id => 1
    )