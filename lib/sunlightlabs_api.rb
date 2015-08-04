require 'json'
require 'open-uri'
require 'date'

class SunlightlabsApi

  DOMAIN = "https://congress.api.sunlightfoundation.com"
  PER_PAGE = 50

  def self.get_bills
    page = 1
    direct_attributes = %w(bill_id bill_type chamber congress cosponsors_count introduced_on official_title popular_title short_title summary_short)
    fields = "actions,bill_id,bill_type,chamber,congress,cosponsors_count,introduced_on,keywords,last_action,last_version.urls.pdf,official_title,popular_title,summary_short,short_title,sponsor.first_name,sponsor.last_name,sponsor.title,urls.govtrack"

    loop do
      url = "#{DOMAIN}/bills?fields=#{fields}&history.active=true&order=last_action_at&introduced_on__gt=%222015-01-01%22&per_page=#{PER_PAGE}&page=#{page}&apikey=#{ENV['SUNLIGHTLABS_APIKEY']}"
      data = JSON.parse(open(url).read)
      results = data['results']
      page_count = data['page']['count']

      results.each do |row|
        values = direct_attributes.map { |attribute| row.fetch(attribute) }
        bill_attributes = Hash[direct_attributes.zip(values)]
        sponsor = row['sponsor']
        legislator = Legislator.where(first_name: sponsor['first_name'], last_name: sponsor['last_name']).first
        bill_attributes['legislator_id'] = legislator.id if legislator
        bill_attributes['url'] = row['urls']['govtrack'] if row['urls']
        last_action = row['last_action']
        if last_action
          bill_attributes['last_action_at'] = Date.parse(last_action['acted_at'])
          bill_attributes['last_action_type'] = last_action['type']
          bill_attributes['last_action_text'] = last_action['text']
        end
        bill_attributes['introduced_on'] = Date.parse(bill_attributes['introduced_on'])
        bill_attributes['last_version_pdf'] = row['last_version']['urls']['pdf'] if row['last_version'] && row['last_version']['urls']

        actions = row['actions']

        bill = Bill.where(bill_attributes).first_or_create

        actions.each do |action|
          BillAction.create(text: action['text'], date: Date.parse(action['acted_at']), bill_id: bill.id, result: action['result'], chamber: action['chamber'])
        end

        row['keywords'].each do |keyword|
          tag = Tag.where(name: keyword).first_or_create
          BillTag.create(tag_id: tag.id, bill_id: bill.id)
        end
      end
      break if page_count < PER_PAGE
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
      break if page_count < PER_PAGE
      page += 1
    end
    keywords.uniq!
    keywords.each { |keyword| Tag.create(name: keyword) }
  end

  def self.get_legislators
    url = "#{DOMAIN}/legislators?per_page=all&apikey=#{ENV['SUNLIGHTLABS_APIKEY']}"
    data = JSON.parse(open(url).read)
    direct_attributes = %w(bioguide_id birthday contact_form district facebook_id fax first_name gender fax in_office last_name leadership_role middle_name name_suffix nickname office party phone state term_end term_start title twitter_id votesmart_id website youtube_id)
    data['results'].each do |row|
      values = direct_attributes.map { |attribute| row.fetch(attribute, nil) }
      legislator_attributes = Hash[direct_attributes.zip(values)]
      Legislator.create(legislator_attributes)
    end
  end
end
