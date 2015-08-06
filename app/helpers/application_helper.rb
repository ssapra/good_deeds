module ApplicationHelper
  def header_text
    content_tag(:span) do
      concat 'Search'
      active_class = 'waves-effect waves-light btn query-filter red active'
      disabled_class = 'waves-effect waves-light btn query-filter red disabled'

      if params[:controller] == 'legislators'
        bill_class = disabled_class
        legislator_class = active_class
      else
        bill_class = active_class
        legislator_class = disabled_class
      end

      concat link_to 'Bills', '#', class: bill_class
      concat ' | '
      concat link_to 'Legislators', '#', class: legislator_class
      concat 'for'
    end
  end

  def body_image
    if request.original_url == root_url
      content_tag(:body, '', class: 'background')
    else
      content_tag(:body)
    end
  end
end
