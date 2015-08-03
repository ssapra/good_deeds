class SearchController < ApplicationController
  def index
    params[:search] = params[:search].to_s.strip
    render('index') && return if params[:search].empty?

    lq = LegislatorQuery.new(Legislator.all, params[:search])
    @legislators = lq.search.order(:in_office, :firstname).page(params[:page])
    @pg_results = PgSearch.multisearch(params[:search])
  end
end
