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

  def current_status
    actions = bill_actions
    if enacted = actions.enacted.first
      bill_actions.order(:created_at).last.text
    elsif signed = actions.signed.first
      "Signed by President"
    elsif passed_house = actions.passed_house.first
      "Passed House on #{passed_house.date.strftime('%b %-d, %Y')}"
    elsif passed_senate = actions.passed_senate.first
      "Passed Senate on #{passed_senate.date.strftime('%b %-d, %Y')}"
    else
      "Introduced to #{chamber}"
    end
  end
end
