require 'rails_helper'

describe BillAction, type: :model do
  describe '.important' do
    before do
      @action_1 = create(:bill_action, text: 'Signed by President.')
      @action_2 = create(:bill_action, text: 'Became Public Law No. 1')
      @action_3 = create(:bill_action, text: 'Nothing happens in Congress')
      @action_4 = create(:bill_action, result: 'pass', chamber: 'senate')
      @action_5 = create(:bill_action, result: 'pass', chamber: 'house')
      @action_6 = create(:bill_action, result: 'pass', chamber: 'other')
    end

    it 'finds bills that have passed a house, been signed, or enacted' do
      expect(BillAction.important).to contain_exactly(@action_1, @action_2, @action_4, @action_5)
    end
  end
end
