class LegislatorsController < ApplicationController
  def index
    if params[:search] && params[:search].to_s.downcase != 'legislators'
      lq = LegislatorQuery.new(Legislator.all, params[:search])
      @legislators = lq.search.order(:in_office, :firstname)
    else
      @legislators = Legislator.order(:in_office, :firstname)
    end
    @num_results = @legislators.count
    @legislators = @legislators.page(params[:page])

  end

  def show
    @legislator = Legislator.find(params[:id])
  end
end
