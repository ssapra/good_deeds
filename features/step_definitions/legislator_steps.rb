Given(/^the following legislators exist:$/) do |table|
  table.hashes.each do |hash|
    Legislator.create(hash)
  end
end

Given(/^the following congressional districts exist:$/) do |table|
  table.hashes.each do |hash|
    CongressionalDistrict.create(hash)
  end
end

Given(/^I visit "(.*?)"$/) do |url|
  visit(url)
end

When(/^I search "(.*?)"$/) do |input|
  fill_in('search', with: input)
  page.execute_script("$('form#search').submit()")
end

When(/^I click on "(.*?)"$/) do |text|
  page.find('tr', text: text).click
end

Then(/^I see (\d+) legislators$/) do |result_count|
  find('#results', match: :first)
  expect(all('#results tbody tr').count).to eq(result_count.to_i)
end

Then(/^I see the legislator page for "(.*?)"$/) do |name|
  legislator = Legislator.find_by_firstname(name)
  expect(page).to have_content(legislator.full_title)
end
