class SendEmailUpdates

  def self.send_emails
    bill_updates = find_bills_with_updates
    User.find_each do |user|
      selected_bills = user.bills.inject({}) do |result, bill|
        result[bill.id] = bill_updates[bill.id]
        result
      end
      BillUpdateMailer.update(user, selected_bills).deliver_now
    end
  end

  private

  def self.find_bills_with_updates
    recent_actions = BillAction.where(updated_at: (Time.zone.now - 24.hours)..Time.zone.now)

    bill_updates = {}

    recent_actions.passed_senate.each_with_object({}) do |action|
      bill_updates[action.bill.id] ||= []
      bill_updates[action.bill.id] <<= action.text
    end

    recent_actions.passed_house.each do |action|
      bill_updates[action.bill.id] ||= []
      bill_updates[action.bill.id] <<= action.text
    end

    recent_actions.signed.each do |action|
      bill_updates[action.bill.id] ||= []
      bill_updates[action.bill.id] <<= action.text
    end

    recent_actions.enacted.each do |action|
      bill_updates[action.bill.id] ||= []
      bill_updates[action.bill.id] <<= action.text
    end

    bill_updates
  end
end
