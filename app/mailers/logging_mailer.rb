class LoggingMailer < ActionMailer::Base
  default :from => ENV["SUPPORT_EMAIL"]

  def log_email(context, message="")
    @context = context
    @message = message
    mail(:to => ENV["SUPPORT_EMAIL"], :subject => "Ocill Logger" ) do |format|
      format.html
    end
  end
end
