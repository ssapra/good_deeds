module TagHelper
  def tag_message(user)
    if user.tags.empty?
      content_tag(:h5, "No tags! Add some below to help us find bills you'll be interested in")
    else
      content_tag(:p, "Based on these tags, we'll find bills that match your interests", class: 'summary')
    end
  end
end
