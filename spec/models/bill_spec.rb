require 'rails_helper'

describe Bill, type: :model do
  describe '#initialize' do
    context 'valid' do
      let(:bill) { build(:bill) }

      it 'is valid with default attributes' do
        expect(bill).to be_valid
      end
    end

    context 'invalid' do
      before do
        create(:bill, bill_id: 'hr1234')
        @bill_2 = build(:bill, bill_id: 'hr1234')
      end

      it 'is valid with default attributes' do
        expect(@bill_2).to_not be_valid
      end
    end
  end
end
