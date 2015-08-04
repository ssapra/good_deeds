json.search_query params[:query]
json.legislators @legislators do |legislator|
  json.extract! legislator, :title, :firstname, :middlename, :lastname, :name_suffix, :nickname, :party, :state, :district, :gender, :phone, :fax, :website, :webform, :congress_office, :bioguide_id, :votesmart_id, :fec_id, :govtrack_id, :crp_id, :twitter_id, :congresspedia_url, :youtube_url, :facebook_id, :official_rss, :senate_class, :birthdate, :oc_email, :in_office
end
