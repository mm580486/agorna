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
            :email => 'mehdi_rezzaei@gmail.com',
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