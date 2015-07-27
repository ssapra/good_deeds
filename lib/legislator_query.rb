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
    build_query(:names, :state, :title, :party)
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
    state_param = default_param
    state_param = "%#{STATES[search_term]}%" if STATES[search_term]
    params.push(state_param)
    query << ' OR state LIKE ?'
  end

  def handle_title
    title_param = default_param
    if %w(Representative Senator Delegate Commissioner).include?(search_term)
      title_param = search_term[0..2]
    end
    params.push(title_param)
    query << ' OR title LIKE ?'
  end

  def handle_party
    party_param = default_param
    if %w(Republican Democratic Indepedent).include?(search_term)
      party_param = search_term[0]
    end
    params.push(party_param)
    query << ' OR party LIKE ?'
  end
end
