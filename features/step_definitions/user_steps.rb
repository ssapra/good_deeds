Given(/^I am a new user$/) do
  @user = create :user, password: 'password'
  fill_sign_in_form(@user.email, 'password')
end

Given(/^I am a user with zipcode "(.*?)"$/) do |zipcode|
  @user = create :user, password: 'password', zipcode: zipcode
  fill_sign_in_form(@user.email, 'password')
end

Given(/^I visit the account page$/) do
  visit("/users/#{@user.id}")
end

When(/^I set "(.*?)" as "(.*?)"$/) do |field, value|
  fill_in(field, with: value)
  click_button('Submit')
end

Then(/^I see "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

Given(/^I am a new user with political party "(.*?)"$/) do |party|
  @user = create :user, password: 'password', political_party: party
  fill_sign_in_form(@user.email, 'password')
end

When(/^I select political party "(.*?)"$/) do |party|
  select(party, from: "user_political_party")
  click_button('Submit')
end
