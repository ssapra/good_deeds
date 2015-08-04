class BillAction < ActiveRecord::Base
  belongs_to :bill, dependent: :destroy

  validates :date, uniqueness: { scope: :text, message: "Duplicate action" }
end
