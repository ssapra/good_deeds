Given(/^these bills exist:$/) do |table|
  table.hashes.each do |attributes|
    create(:bill, attributes)
  end
end

Then(/^I see no results found$/) do
  expect(page).to have_content("No results found")
end
