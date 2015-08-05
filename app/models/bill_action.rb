class BillAction < ActiveRecord::Base
  belongs_to :bill

  scope :passed_senate, -> { where(result: 'pass', chamber: 'senate') }
  scope :passed_house, -> { where(result: 'pass', chamber: 'house') }
  scope :signed, -> { where(text: 'Signed by President.') }
  scope :enacted, -> { where('text LIKE ?', '%Became Public Law%') }

  def important?
    result == 'pass' || text == 'Signed by President.' || text.include?('Became Public Law')
  end
end
