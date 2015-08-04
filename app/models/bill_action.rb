class BillAction < ActiveRecord::Base
  belongs_to :bill

  validates :date, uniqueness: { scope: :text, message: "Duplicate action" }
end
