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

Given(/^there exists tags "(.*?)"$/) do |tag_names|
  tag_names.split(', ').each { |name| Tag.create(name: name) }
end

When(/^I select "(.*?)"$/) do |tag|
  select(tag, from: "user_user_tags_attributes_0_tag_id")
  click_button('Submit')
end

When(/^I remove "(.*?)"$/) do |tag_name|
  tag = Tag.find_by_name(tag_name)
  page.find(:xpath, "//*[@id='edit_user_#{@user.id}']/li[@data-tag-id='#{tag.id}']/a").click
end

Given(/^I am a new user with tags "(.*?)"$/) do |tag_names|
  @user = create :user, password: 'password'
  fill_sign_in_form(@user.email, 'password')
  tag_names.split(', ').each do |tag_name|
    t = create(:tag, name: tag_name)
    UserTag.create(tag_id: t.id, user_id: @user.id)
  end
end

Then(/^I have (\d+) tags$/) do |num|
  expect(@user.tags.count).to eq(num.to_i)
end
