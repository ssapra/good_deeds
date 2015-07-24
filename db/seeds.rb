require 'csv'

Tag.destroy_all
Legislator.destroy_all
CongressionalDistrict.destroy_all

tag_names = ["Agriculture", "Forestry", "Fishing", "Hunting", "Real estate",
             "Rental", "Leasing", "Company and enterprise management",
             "Manufacturing", "Government", "Education", "Transportation",
             "Military"]

tag_names.each { |name| Tag.create(name: name) }

CSV.foreach("legislators.csv", headers: true) do |row|
  Legislator.create(row.to_h)
end

header = ["zipcode", "state", "congressional_district_id"]

CSV.foreach("districts.csv") do |row|
  CongressionalDistrict.create(Hash[header.zip(row)])
end

