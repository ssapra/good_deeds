Given(/^I am new user with (\d+) bookmarks$/) do |num|
  @user = create :user, password: 'password'
  fill_sign_in_form(@user.email, 'password')
  num.to_i.times do
    bill = create(:bill)
    create(:bookmark, bill_id: bill.id, user_id: @user.id)
  end
end

Given(/^I visit the bookmarks page$/) do
  visit('/bookmarks')
end

Given(/^I visit a bill$/) do
  bill = create(:bill)
  visit("/bills/#{bill.bill_id}")
end

When(/^I remove the first bookmark$/) do
  find(".remove a", match: :first).click
end

When(/^I bookmark the bill$/) do
  click_on('Add to bookmarks')
end

When(/^I click on the first one$/) do
  find("tbody tr", match: :first).click
end

Then(/^I have no bills$/) do
  expect(page).to have_content('No bookmarks yet!')
end

Then(/^I can not bookmark$/) do
  expect(page).to_not have_content('Add to bookmarks')
end

Then(/^I should see (\d+) bills$/) do |num|
  expect(page).to have_css('#results')
  expect(all('tbody tr').count).to eq(num.to_i)
end

Then(/^I should see 1 bill$/) do
  expect(page).to have_css('#results')
  expect(all('tbody tr').count).to eq(1)
end

Then(/^I see the bill page for "(.*?)"$/) do |title|
  bill = Bill.find_by_short_title(title)
  expect(page).to have_content(bill.type_and_num)
end

Then(/^I see the bill page$/) do
  expect(page).to have_content("Sponsor")
end
