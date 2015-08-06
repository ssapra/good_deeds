class BillAction < ActiveRecord::Base
  belongs_to :bill

  scope :passed_senate, -> { where(result: 'pass', chamber: 'senate') }
  scope :passed_house, -> { where(result: 'pass', chamber: 'house') }
  scope :signed, -> { where(text: 'Signed by President.') }
  scope :enacted, -> { where('text LIKE ?', '%Became Public Law%') }

  def important?
    flag1 = result == 'pass'
    flag2 = text == 'Signed by President.'
    flag3 = text.include?('Became Public Law')

    flag1 || flag2 || flag3
  end
end
