FactoryGirl.define do
  factory :user_bill do
    user_id { rand(100) }
    bill_id { rand(100) }
  end
end
