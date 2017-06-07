class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  belongs_to :product
  validates_length_of :body, within: 2..300, too_long: 'pick a shorter name', too_short: 'pick a longer name'
end
