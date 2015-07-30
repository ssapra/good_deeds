class LegislatorQuery
  attr_reader :relation, :query, :params, :search_term

  def initialize(relation, search_term)
    @relation = relation
    @query = []
    @params = []
    @search_term = search_term
  end

  def search
    build_query(:zipcode, :party, :state, :title, :names)
    relation.where(query.join(" OR "), *params)
  end

  private

  def build_query(*parameters)
    parameters.each { |param| send("handle_#{param}") }
  end

  def handle_names
    normalized_name = search_term.downcase.titleize
    @params.push(normalized_name, normalized_name)
    @query << 'firstname LIKE ? OR lastname LIKE ?'
  end

  def handle_state
    normalized_full_state_name = search_term.downcase.titleize
    noramlized_state_abbreviation = search_term.upcase
    return unless STATES[normalized_full_state_name] ||
                  STATES.values.include?(noramlized_state_abbreviation)

    if STATES[normalized_full_state_name]
      @params.push(STATES[normalized_full_state_name])
    else
      @params.push(noramlized_state_abbreviation)
    end
    @query << 'state = ?'
  end

  def handle_title
    return unless %w(representative senator delegate commissioner rep sen del com).include?(search_term.downcase)
    title_param = search_term[0..2].capitalize
    @params.push(title_param)
    @query << 'title = ?'
  end

  def handle_party
    return unless %w(republican democratic indepedent).include?(search_term.downcase)
    party_param = search_term[0].upcase
    @params.push(party_param)
    @query << 'party = ?'
  end

  def handle_zipcode
    return unless search_term =~ /^\d{5}$/
    state = search_term.to_region(state: true)
    @params.push(state)
    district_ids = CongressionalDistrict.where(zipcode: search_term)
                                        .map(&:congressional_district_id)
                                        .map(&:to_s)
    @params.push(district_ids)
    @query << '(state = ? AND district IN (?))'
  end
end
