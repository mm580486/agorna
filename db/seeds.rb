# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Setting.create({
    site_name: '',
    seo_description: 'agorna site',
    seo_keywords: 'site'
})

User.create(:name => 'محمد محمودی',
            :email => 'mm580486@yahoo.com',
            :password => 'Microlab12546',
            :password_confirmation => 'Microlab12546',
            :level => 3
                 )

