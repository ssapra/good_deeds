class BillsController < ApplicationController
  def index
    search_params = query_params[:query].to_s.strip
    render('index') && return if search_params.empty?

    @pg_results = PgSearch.multisearch(search_params)
    @num_bills = @pg_results.count
    @pg_results = @pg_results.page(params[:page])
  end

  def random_good_deed
    if current_user
      tag_bills = current_user.tags.map(&:bills)
      legislator_bills = current_user.legislators_by_zipcode.map(&:bills)
      bills = (tag_bills + legislator_bills).flatten
      @bill = bills.sample
    else
      @bill = Bill.all.sample
    end
    redirect_to "/bills/#{@bill.bill_id}"
  end

  def show
    @bill = Bill.find_by_bill_id(params[:bill_id])
  end

  private

    def query_params
      params.permit(:query)
    end
end
