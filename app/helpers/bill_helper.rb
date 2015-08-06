module BillHelper
  def bill_title
    content_tag(:h5) do
      concat @bill.type_and_num
      concat ': '
      titles = [@bill.popular_title, @bill.short_title, @bill.official_title]
      concat titles.compact.first
    end
  end

  def bill_current_status
    actions = @bill.bill_actions
    bill_status = ''
    if actions.enacted.first
      bill_status = actions.order(:created_at).last.text
    elsif actions.signed.first
      bill_status = 'Signed by President'
    end

    return bill_status if !bill_status.empty?

    house_action = actions.passed_house.first
    senate_action = actions.passed_senate.first
    determine_bill_state(house_action, senate_action)
  end

  def determine_bill_state(house_action, senate_action)
    if (@bill.bill_type == 'sres' && senate_action) || (@bill.bill_type == 'hres' && house_action)
      'Agreed To Simple Resolution'
    elsif %w(sconres hconres).include?(@bill.bill_type) && house_action && senate_action
      'Agreed To Concurrent Resolution'
    elsif (%w(hr hconres).include?(@bill.bill_type) && house_action && senate_action.nil?) || (@bill.bill_type == 's' && senate_action && house_action)
      (@bill.bill_type == 's' && house_action) || (@bill.bill_type == 'hr' && senate_action.nil?)
      "Passed House on #{house_action.date.strftime('%b %-d, %Y')}"
    elsif (%w(s sconres).include?(@bill.bill_type) && senate_action && house_action.nil?) || (@bill.bill_type == 'hr' && senate_action && house_action)
      "Passed Senate on #{senate_action.date.strftime('%b %-d, %Y')}"
    elsif house_action.nil? && senate_action.nil?
      "Introduced to #{@bill.chamber.capitalize}"
    end
  end

  def bookmark_options
    return unless current_user
    if UserBill.exists?(user_id: current_user.id, bill_id: @bill.id)
      already_bookmarked
    else
      allow_bookmark_action
    end
  end

  def already_bookmarked
    content_tag(:p) do
      concat icon('bookmark')
      concat 'Bookmarked!'
    end
  end

  def allow_bookmark_action
    content_tag(:p) do
      link_to icon('bookmark_border') << 'Add to bookmarks', bookmarks_path(bill_id: @bill.id), method: :post
    end
  end

  def icon(text)
    content_tag(:i, text, class: 'material-icons')
  end

  def bill_action_text(action)
    date = action.date.strftime('%B %-d, %Y')
    date_class = 'col s3'
    text_class = 'col s9'
    date_class << ' bold' if @important_actions.include?(action)
    text_class << ' bold' if @important_actions.include?(action)
    content_tag(:tr) do
      concat content_tag(:td, date, class: date_class)
      concat content_tag(:td, action.text, class: text_class)
    end
  end
end
