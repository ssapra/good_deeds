class LegislatorsController < ApplicationController
  def index
    if params[:search] && params[:search].to_s.downcase != 'legislators'
      lq = LegislatorQuery.new(Legislator.all, params[:search])
      @legislators = lq.search.page(params[:page])
    else
      @legislators = Legislator.page(params[:page])
    end
  end

  def show
    @legislator = Legislator.find(params[:id])
  end
end
