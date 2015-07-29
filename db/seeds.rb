require 'csv'

Legislator.destroy_all
CongressionalDistrict.destroy_all

CSV.foreach("legislators.csv", headers: true) do |row|
  Legislator.create(row.to_h)
end

header = ["zipcode", "state", "congressional_district_id"]

CSV.foreach("districts.csv") do |row|
  CongressionalDistrict.create(Hash[header.zip(row)])
end
