class Bill < ActiveRecord::Base
  validates :bill_id, uniqueness: true
  belongs_to :legislator
end
