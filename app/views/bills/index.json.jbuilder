json.bills @pg_results do |pg_result|
  json.extract! pg_result.searchable, :bill_id, :bill_type, :chamber, :congress, :cosponsors_count, :introduced_on, :official_title, :popular_title, :short_title, :summary_short, :url, :last_action_at, :last_version_pdf, :legislator_id
end
