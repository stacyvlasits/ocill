class NewRegistration < ActionMailer::Base
  default :from => "stacyvlasits@austin.utexas.edu"

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
