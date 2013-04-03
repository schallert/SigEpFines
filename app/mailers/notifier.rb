class Notifier < ActionMailer::Base
  default :from => "fines@sigepcmu.org"

  def reminder (fine)
    @brother = fine.brother
    @fine = fine
    # NOTE: this won't send the email, just deliver a mail object
    # Call `.deliver` on the returned object to send the email
    mail(
      :to => @brother.email,
      :subject => "Pending Fine"
    )
  end
end
