class Tag < ActiveRecord::Base
  has_many :user_tags
  has_many :users
end
