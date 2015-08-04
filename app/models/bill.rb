class Bill < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:official_title, :short_title, :summary_short]

  validates :bill_id, uniqueness: true
  belongs_to :legislator

  has_many :bill_tags, dependent: :destroy
  has_many :tags, through: :bill_tags

  has_many :bill_actions, dependent: :destroy

  def title
    bill_num = /[a-z]*(\d*)-\d*/.match(bill_id)[1]

    bill_types = {"hr" => "H.R.", "s" => "S.", "hres" => "H.Res.", "sres" => "S.Res.", "sjres" => "S.J.Res", "hjres" => "H.J.Res", "hconres" => "H.Con.Res", "sconres" => "S.Con.Res"}

    bill_type_abbreviation = bill_types[bill_type]
    "#{bill_type_abbreviation} #{bill_num}"
  end

  def bookmarked_by_user?(user_id)
    UserBill.exists?(user_id: user_id, bill_id: self.id)
  end

  def passed_senate?
    bill_actions.exists?(chamber: 'senate', result: 'pass')
  end

  def passed_house?
    bill_actions.exists?(chamber: 'house', result: 'pass')
  end

  def introduced?
    true
  end

  def signed_by_president?
    bill_actions.exists?(text: 'Signed by President.')
  end

  def enacted?
    bill_actions.exists? { |ba| ba.text.include?('Became Public Law') }
  end

  def current_status
    if enacted?
      bill_actions.order(:date).last.text
    elsif signed_by_president?
      "Signed by President"
    elsif passed_house?
      bill_actions.where(chamber: 'house', result: 'pass').first.text
    elsif passed_senate?
      bill_actions.where(chamber: 'senate', result: 'pass').first.text
    else
      "Introduced to #{chamber}"
    end
  end
end
