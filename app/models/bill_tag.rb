class BillTag < ActiveRecord::Base
  belongs_to :bill, dependent: :destroy
  belongs_to :tag, dependent: :destroy

  validates :bill_id, uniqueness: { scope: :tag_id, message: "Duplicate tag" }
end
