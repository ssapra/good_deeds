class Legislator < ActiveRecord::Base
  paginates_per 50
  has_many :bills

  def verbose_summary
    land = STATES.key(state)

    if title == 'Del' || title == 'Com' || district == '0'
      "#{full_title} for #{land} At Large"
    elsif title == 'Rep' && district != '0'
      "#{full_title} for #{land}'s #{district.to_i.ordinalize} congressional district"
    else
      "#{full_title} from #{land}"
    end
  end

  def full_leadership_role
    if leadership_role == 'Speaker'
      'Speaker of the House'
    else
      "House #{leadership_role}"
    end
  end

  def bioguide_url
    "http://bioguide.congress.gov/scripts/biodisplay.pl?index=#{bioguide_id}"
  end

  def votesmart_url
    "http://votesmart.org/candidate/#{votesmart_id}/#{first_name}-#{last_name}"
  end

  def age
    dob = Date.parse(birthday)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def full_title
    case title
    when 'Sen'
      'Senator'
    when 'Rep'
      'Representative'
    when 'Com'
      'Commissioner'
    when 'Del'
      'Delegate'
    end
  end

  def full_party
    case party
    when 'D'
      'Democrat'
    when 'R'
      'Republican'
    else
      'Independent'
    end
  end

  def name
    [first_name, middle_name, last_name].compact.join(' ')
  end
end
