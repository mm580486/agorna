class MarketerTask < ActiveRecord::Base
    belongs_to :user
    belongs_to :seller, :class_name => "User",foreign_key: "user_two"
end
