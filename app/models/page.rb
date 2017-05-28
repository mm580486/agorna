class Page < ActiveRecord::Base
  belongs_to :user,required: true
  validates_presence_of :title
  validates_length_of :title, :minimum => 3, :maximum => 300
  validates_presence_of :permalink
  validates_length_of :permalink, :minimum => 3, :maximum => 255
  validates_uniqueness_of :permalink
  validates_presence_of :content
  validates_length_of :content, :minimum => 3
end
