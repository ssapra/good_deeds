class LegislatorsController < ApplicationController
  before_action :ensure_nonempty_query, only: :index

  def index
    lq = LegislatorQuery.new(Legislator.all, @search_params)
    @legislators = lq.search.order(:first_name)
    @num_legislators = @legislators.count
    @legislators = @legislators.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render 'index', layout: false }
    end
  end

  def show
    @legislator = Legislator.find(params[:id])
  end

  private

  def query_params
    params.permit(:query)
  end
end
