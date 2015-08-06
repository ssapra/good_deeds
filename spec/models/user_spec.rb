require 'rails_helper'

describe User, type: :model do
  describe '#new' do
    context 'with valid attributes' do
      let(:user) { build(:user) }

      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'with invalid attributes' do
      context 'with invalid email' do
        let(:user) { build(:user, email: 'bogus') }

        it 'is invalid' do
          expect(user).to_not be_valid
        end
      end

      context 'with duplicate email' do
        before do
          create(:user, email: 'test@test.com')
          @user_2 = build(:user, email: 'test@test.com')
        end

        it 'is invalid' do
          expect(@user_2).to_not be_valid
        end
      end

      context 'with bogus zipcode' do
        let(:user) { build(:user, zipcode: 'abcde') }

        it 'is invalid' do
          user.save
          expect(user).to_not be_valid
        end
      end

      context 'with zipcode that does not match a city' do
        let(:user) { build(:user, zipcode: '99999') }

        it 'is invalid' do
          user.save
          expect(user).to_not be_valid
        end
      end
    end
  end
end
