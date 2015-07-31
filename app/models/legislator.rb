class Legislator < ActiveRecord::Base
  paginates_per 50
  has_many :bills

  def all_info
    full_title << " #{party[0]}-#{state}"
  end

  def full_title
    [title.to_s << '.', name].join(' ')
  end

  def name
    [firstname, middlename, lastname].compact.join(' ')
  end
end
