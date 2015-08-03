class Bill < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:official_title, :short_title, :summary_short]

  validates :bill_id, uniqueness: true
  belongs_to :legislator

  has_many :bill_tags
  has_many :tags, through: :bill_tags

  has_many :bill_actions

  def title
    bill_num = /[a-z]*(\d*)-\d*/.match(bill_id)[1]

    bill_types = {"hr" => "H.R.", "s" => "S.", "hres" => "H.Res.", "sres" => "S.Res.", "sjres" => "S.J.Res", "hjres" => "H.J.Res", "hconres" => "H.Con.Res", "sconres" => "S.Con.Res"}

    bill_type_abbreviation = bill_types[bill_type]
    "#{bill_type_abbreviation} #{bill_num}"
  end

  def bookmarked_by_user?(user_id)
    UserBill.exists?(user_id: user_id, bill_id: self.id)
  end
end
