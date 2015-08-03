Given(/^I am new user with (\d+) bookmarks$/) do |num|
  @user = create :user, password: 'password'
  fill_sign_in_form(@user.email, 'password')
  num.to_i.times do
    bill = create(:bill)
    create(:user_bill, bill_id: bill.id, user_id: @user.id)
  end
end

Given(/^I visit a bill$/) do
  bill = create(:bill)
  visit("/bills/#{bill.bill_id}")
end

When(/^I remove the first bookmark$/) do
  find(".remove a", match: :first).click
end

Then(/^I have no bills$/) do
  expect(page).to have_content('No bookmarks yet! Check out some')
end

Then(/^I can not bookmark$/) do
  expect(page).to_not have_content('Bookmark')
end

Then(/^I see (\d+) bills$/) do |num|
  expect(page).to have_css('#results')
  expect(all('tr').count).to eq(num.to_i)
end
