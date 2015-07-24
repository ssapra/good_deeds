require 'rails_helper'

describe Tag, type: :model do
  describe '#new' do
    context 'with valid attributes' do
      let(:tag) { build(:tag, name: "Agriculture") }

      it 'is valid' do
        expect(tag).to be_valid
      end
    end

    context 'with invalid attributes' do
      context 'name too short' do
        let(:tag) { build(:tag, name: "Th") }

        it 'is not valid' do
          expect(tag).to_not be_valid
        end
      end

      context 'name too long' do
        let(:tag) { build(:tag, name: "Department of Commerce and Industry") }

        it 'is not valid' do
          expect(tag).to_not be_valid
        end
      end
    end
  end
end
