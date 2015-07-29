FactoryGirl.define do
  factory :bill do
    bill_id "MyString"
    bill_type "MyString"
    chamber "house"
    congress 114
    cosponsors_count { rand(10) }
    introduced_on "2015-06-29"
    official_title "MyString"
    popular_title "MyString"
    short_title "MyString"
    summary_short "MyText"
    url "MyString"
    last_action_at "2015-07-29"
    last_action_type "MyString"
    last_action_text "MyText"
    last_version_pdf "MyString"
    legislator_id 1
  end
end
