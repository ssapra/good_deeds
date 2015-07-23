Given(/^I am signed out$/) do
  page.driver.delete('/users/sign_out')
end

Given(/^I have an account$/) do
  @email = 'me@home.com'
  @password = 'password'
  @user = User.create(email: @email, password: @password)
end

When(/^I visit my account$/) do
  visit("/users/#{@user.id}")
end

When(/^I sign in correctly$/) do
  fill_in('user_email', with: @email)
  fill_in('user_password', with: @password)
  click_button('Log in')
end

Then(/^I see the account page$/) do
  expect(page).to have_content('My Account')
end
