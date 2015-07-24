tag_names = ["Agriculture", "Forestry", "Fishing", "Hunting", "Real estate",
             "Rental", "Leasing", "Company and enterprise management",
             "Manufacturing", "Government", "Education", "Transportation",
             "Military"]

tag_names.each { |name| Tag.create(name: name) }
