class Legislator < ActiveRecord::Base
  paginates_per 50

  def full_title
    [title.to_s << '.', name].join(' ')
  end

  def name
    [firstname, middlename, lastname].join(' ')
  end
end
