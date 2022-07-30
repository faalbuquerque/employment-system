class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.new_appliance.subject
  #
  def new_appliance(**args)
    @candidate = args[:candidate]
    @job = args[:job]

    mail to: @job.company.collaborators.first.email,
    subject: 'Houve uma nova candidatura'
  end
end
