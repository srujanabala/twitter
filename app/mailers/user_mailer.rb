class UserMailer < ActionMailer::Base
  default from: "test@twitter.com"

  def confirm_email(user)
    @user = user
    mail(to: user.email, subject: "Confirm your email for Shitty Twitter")
  end
end
