FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    zipcode { Area.zip_codes.reject(&:empty?).sample.first }
    political_party { ["Democrat", "Republican", "Independent"].sample }
  end
end
