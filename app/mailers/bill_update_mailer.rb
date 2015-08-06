class BillUpdateMailer < ActionMailer::Base
  default from: 'help@gooddeeds.com'

  def update(user, bills)
    @user = user
    @bills  = bills
    mail(to: @user.email, subject: 'Good Deeds Updates for your bookmarked bills')
  end
end
