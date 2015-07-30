class Bill < ActiveRecord::Base
  validates :bill_id, uniqueness: true
  belongs_to :legislator

  has_many :bill_tags
  has_many :tags
end
