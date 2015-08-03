class BillsController < ApplicationController
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
end
