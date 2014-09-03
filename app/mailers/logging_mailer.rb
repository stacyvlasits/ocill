class LoggingMailer < ActionMailer::Base
  default :from => ENV["SUPPORT_EMAIL"]

  def log_email(message="", *context)
    # pass in whatever you want as the context
    # the mailer will render it as json and include it in your email.
    @context = context
    @message = message
    mail(:to => ENV["SUPPORT_EMAIL"], :subject => "Ocill Logger" ) do |format|
      format.html
    end
  end
end
