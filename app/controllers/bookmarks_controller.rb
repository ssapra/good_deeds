class BookmarksController < ApplicationController
  before_filter :authenticate_user!
  def create
    bill = Bill.find(params[:bill_id])
    UserBill.create(user_id: current_user.id, bill_id: params[:bill_id])
    redirect_to bill_path(bill_id: bill.bill_id), notice: "Bookmarked!"
  end

  def index
    @bills = current_user.bills.page(params[:page])
  end

  def destroy
    UserBill.find_by_user_id_and_bill_id(current_user.id, params[:bill_id]).destroy
    redirect_to bookmarks_path
  end
end
