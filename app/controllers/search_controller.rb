class SearchController < ApplicationController
  def index
    search_params = query_params[:query].to_s.strip
    render('index') && return if search_params.empty?

    lq = LegislatorQuery.new(Legislator.all, search_params)
    @legislators = lq.search.order(:in_office, :firstname).page(params[:page])
    @pg_results = PgSearch.multisearch(search_params)
  end

  private

    def query_params
      params.permit(:query)
    end
end
