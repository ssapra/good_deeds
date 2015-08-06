FactoryGirl.define do
  factory :bill_action do
    text { Faker::Lorem.sentence }
    date { Faker::Date.forward(23) }
    bill_id { rand(100) }
  end
end
