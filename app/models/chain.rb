class Chain < ActiveRecord::Base
    validates :user_id, presence: true
    validates :user_two, presence: true
    belongs_to :user
end
