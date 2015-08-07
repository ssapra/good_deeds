require 'rails_helper'

describe SendEmailUpdates do
  describe '.send_emails' do
    before do
      action_1 = create(:bill_action, text: 'Signed by President.', date: 10.minutes.ago)
      action_2 = create(:bill_action, text: 'Became Public Law No. 1', date: 10.hours.ago)
      action_3 = create(:bill_action, text: 'Nothing happens in Congress', date: 24.days.ago)
      user_bill = create(:user_bill, bill_id: action_1.bill_id)
      create(:user_bill, bill_id: action_2.bill_id, user_id: user_bill.user.id)
      create(:user_bill, bill_id: action_3.bill_id)
    end

    after do
      ActionMailer::Base.deliveries.clear
    end

    it "sends an email to 1 user" do
      expect { SendEmailUpdates.send_emails }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe '.find_recent_important_bills' do
    before do
      @bill_1 = create(:bill)
      @bill_2 = create(:bill)
      @bill_3 = create(:bill)
      @action_1 = create(:bill_action, bill_id: @bill_1.id, text: 'Signed by President.', date: 2.days.ago)
      @action_2 = create(:bill_action, bill_id: @bill_1.id, text: 'Became Public Law No. 1', date: 48.hours.ago)
      @action_3 = create(:bill_action, bill_id: @bill_1.id, text: 'Nothing happens in Congress', date: 5.minutes.ago)
      @action_4 = create(:bill_action, bill_id: @bill_2.id, result: 'pass', chamber: 'senate', date: 5.hours.ago)
      @action_5 = create(:bill_action, bill_id: @bill_2.id, result: 'pass', chamber: 'house', date: 1.month.ago)
      @action_6 = create(:bill_action, bill_id: @bill_3.id, result: 'pass', chamber: 'house', date: Time.zone.now.utc - 23.hours)
      @action_7 = create(:bill_action, bill_id: @bill_3.id, result: 'pass', chamber: 'other', date: 1.day.from_now)
    end

    it 'contains certain bill ids with their actions' do
      expect(SendEmailUpdates.find_recent_important_bills.keys).to contain_exactly(@bill_2.id, @bill_3.id)
    end
  end
end
