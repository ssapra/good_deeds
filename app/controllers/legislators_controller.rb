class LegislatorsController < ApplicationController

  def index
    search_params = query_params[:query].to_s.strip
    render('index') && return if search_params.empty?

    lq = LegislatorQuery.new(Legislator.all, search_params)
    @legislators = lq.search.order(:in_office, :firstname)
    @num_legislators = @legislators.count
    @legislators = @legislators.page(params[:page])
  end

  def show
    @legislator = Legislator.find(params[:id])
  end

  private

    def query_params
      params.permit(:query)
    end
end
