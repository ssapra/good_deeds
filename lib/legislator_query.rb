class LegislatorQuery
  attr_accessor :relation, :query, :params, :search_term, :default_param

  def initialize(relation, search_term)
    @relation = relation
    @query = ''
    @params = []
    @search_term = search_term
    @default_param = "%#{search_term}%"
  end

  def search
    build_query(:names, :state, :title, :party, :zipcode)
    relation.where(query, *params)
  end

  private

  def build_query(*parameters)
    parameters.each { |param| send("handle_#{param}") }
  end

  def handle_names
    params.push(default_param, default_param)
    query << 'firstname LIKE ? OR lastname LIKE ?'
  end

  def handle_state
    return unless STATES[search_term]
    params.push(STATES[search_term])
    query << ' OR state = ?'
  end

  def handle_title
    return unless %w(Representative Senator Delegate Commissioner).include?(search_term)
    title_param = search_term[0..2]
    params.push(title_param)
    query << ' OR title = ?'
  end

  def handle_party
    return unless %w(Republican Democratic Indepedent).include?(search_term)
    party_param = search_term[0]
    params.push(party_param)
    query << ' OR party = ?'
  end

  def handle_zipcode
    return unless search_term =~ /^\d{5}$/
    state = search_term.to_region(state: true)
    params.push(state)
    district_ids = CongressionalDistrict.where(zipcode: search_term)
                                        .map(&:congressional_district_id)
                                        .map(&:to_s)
    params.push(district_ids)
    query << ' OR (state = ? AND district IN (?))'
  end
end
