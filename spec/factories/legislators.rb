FactoryGirl.define do
  factory :legislator do
    title 'Rep'
    firstname { Faker::Name.first_name }
    middlename 'MyString'
    lastname { Faker::Name.last_name }
    nickname 'MyString'
    party 'D'
    state 'IL'
    district '2'
    in_office '1'
    gender 'M'
    phone 'MyString'
    fax 'MyString'
    website 'MyString'
    webform 'MyString'
    congress_office 'MyString'
    bioguide_id 'MyString'
    votesmart_id 'MyString'
    fec_id 'MyString'
    govtrack_id 'MyString'
    crp_id 'MyString'
    twitter_id 'MyString'
    congresspedia_url 'MyString'
    youtube_url 'MyString'
    facebook_id 'MyString'
    official_rss 'MyString'
    senate_class 'MyString'
    birthdate 'MyString'
    oc_email 'MyString'
  end
end
