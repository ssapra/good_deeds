class SendEmailUpdates
  def self.send_emails
    bill_updates = find_bills_with_updates
    User.find_each do |user|
      selected_bills = user.bills.each_with_object({}) do |result, bill|
        result[bill.id] = bill_updates[bill.id]
        result
      end
      BillUpdateMailer.update(user, selected_bills).deliver_now
    end
  end

  def self.find_bills_with_updates
    recent_actions = BillAction.recent
    all_actions = [recent_actions.passed_senate,
                   recent_actions.passed_house,
                   recent_actions.signed,
                   recent_actions.enacted
                  ].flatten

    all_actions.each_with_object({}) do |action, bill_updates|
      bill_updates[action.bill.id] ||= []
      bill_updates[action.bill.id] <<= action.text
    end
  end
end
