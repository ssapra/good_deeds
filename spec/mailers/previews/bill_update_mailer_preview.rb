class BillUpdateMailerPreview < ActionMailer::Preview
  def update
    BillUpdateMailer.update(User.first, {655=>["Resolution agreed to in Senate with amendments by Yea-Nay Vote. 52 - 46. Record Vote Number: 135.", "Senate agreed to conference report by Yea-Nay Vote. 51 - 48. Record Vote Number: 171.", "On agreeing to the conference report Agreed to by the Yeas and Nays: 226 - 197 (Roll no. 183)."]})
  end
end
