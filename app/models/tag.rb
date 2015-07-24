class Tag < ActiveRecord::Base
  has_many :user_tags
  has_many :users
  validates :name, length: { in: 3..20 }
end
