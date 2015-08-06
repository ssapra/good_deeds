module BillHelper
  def bill_title(bill)
    content_tag(:h5) do
      concat bill.title
      concat ': '
      titles = [bill.popular_title, bill.short_title, bill.official_title]
      concat titles.compact.first
    end
  end

  def bill_current_status(bill)
    actions = bill.bill_actions
    if actions.enacted.first
      actions.order(:created_at).last.text
    elsif actions.signed.first
      'Signed by President'
    elsif (house_action = actions.passed_house.first) || (senate_action = actions.passed_senate.first)
      determine_bill_state(bill, house_action, senate_action)
    else
      "Introduced to #{bill.chamber.capitalize}"
    end
  end

  def determine_bill_state(bill, house_action, senate_action)
    if (bill.bill_type == 'sres' && senate_action) || (bill.bill_type == 'hres' && house_action)
      'Agreed To Simple Resolution'
    elsif (bill.bill_type == 'sconres' || bill.bill_type == 'rconres') && house_action && senate_action
      'Agreed To Concurrent Resolution'
    elsif (bill.chamber == 'senate' && house_action) || (bill.chamber == 'house' && senate_action.nil?)
      "Passed House on #{house_action.date.strftime('%b %-d, %Y')}"
    else
      "Passed Senate on #{senate_action.date.strftime('%b %-d, %Y')}"
    end
  end

  def bookmark_options(bill)
    return unless current_user
    if UserBill.exists?(user_id: current_user.id, bill_id: bill.id)
      already_bookmarked
    else
      allow_bookmark_action(bill)
    end
  end

  def already_bookmarked
    content_tag(:p) do
      concat icon('bookmark')
      concat 'Bookmarked!'
    end
  end

  def allow_bookmark_action(bill)
    content_tag(:p) do
      link_to icon('bookmark_border') << 'Add to bookmarks', bookmarks_path(bill_id: bill.id), method: :post
    end
  end

  def icon(text)
    content_tag(:i, text, class: 'material-icons')
  end

  def bill_action_text(action)
    date = action.date.strftime('%B %-d, %Y')
    date_class = 'col s3'
    text_class = 'col s9'
    date_class << ' bold' if action.important?
    text_class << ' bold' if action.important?
    content_tag(:tr) do
      concat content_tag(:td, date, class: date_class)
      concat content_tag(:td, action.text, class: text_class)
    end
  end
end
