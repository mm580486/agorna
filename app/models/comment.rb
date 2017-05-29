class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  belongs_to :product
end
