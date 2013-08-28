class NewRegistration < ActionMailer::Base
  default :from => ENV["SUPPORT_EMAIL"]

  def welcome_email(user, role="", creator)
    @user = user
    @role = role
    @creator = creator
    mail(:to => @user.email, :subject => "Welcome to OCILL" ) do |format|
      format.text
      format.html
    end
  end
end
