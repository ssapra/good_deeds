require 'json'
require 'open-uri'
require 'date'

class SunlightlabsApi

  DOMAIN = "https://congress.api.sunlightfoundation.com"
  PER_PAGE = 50

  def self.get_bills
    per_page = 50
    page = 1
    direct_attributes = %w(bill_id bill_type chamber congress cosponsors_count introduced_on official_title popular_title short_title summary_short)
    fields = "bill_id,bill_type,chamber,congress,cosponsors_count,introduced_on,keywords,last_action,last_version.urls.pdf,official_title,popular_title,summary_short,short_title,sponsor.first_name,sponsor.last_name,sponsor.title,urls.govtrack"

    loop do
      url = "#{DOMAIN}/bills?fields=#{fields}&history.active=true&order=last_action_at&introduced_on__gt=%222015-01-01%22&per_page=#{PER_PAGE}&page=#{page}&apikey=#{ENV['SUNLIGHTLABS_APIKEY']}"
      data = JSON.parse(open(url).read)
      results = data['results']
      page_count = data['page']['count']

      results.each do |row|
        values = direct_attributes.map { |attribute| row.fetch(attribute) }
        bill = Hash[direct_attributes.zip(values)]
        sponsor = Legislator.where(firstname: sponsor['first_name'], lastname: sponsor['last_name']).first
        bill['legislator_id'] = sponsor.id if sponsor
        bill['url'] = row['urls']['govtrack'] if row['urls']
        last_action = row['last_action']
        if last_action
          bill['last_action_at'] = Date.parse(last_action['acted_at'])
          bill['last_action_type'] = last_action['type']
          bill['last_action_text'] = last_action['text']
        end
        bill['introduced_on'] = Date.parse(bill['introduced_on'])
        bill['last_version_pdf'] = row['last_version']['urls']['pdf'] if row['last_version'] && row['last_version']['urls']
        keywords += row['keywords']
        Bill.create(bill)
      end
      break if page_count < per_page
      page += 1
    end
  end

  def self.get_keywords
    keywords = []
    page = 1
    loop do
      url = "#{DOMAIN}/bills?fields=keywords&history.active=true&order=last_action_at&introduced_on__gt=%222015-01-01%22&per_page=#{PER_PAGE}&page=#{page}&apikey=#{ENV['SUNLIGHTLABS_APIKEY']}"
      data = JSON.parse(open(url).read)
      results = data['results']
      page_count = data['page']['count']
      results.each do |row|
        keywords += row['keywords']
      end
      break if page_count < per_page
      page += 1
    end
    keywords.uniq!
    keywords.each { |keyword| Tag.create(name: keyword) }
  end
end
