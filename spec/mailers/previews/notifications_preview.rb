# Preview all emails at http://localhost:3000/rails/mailers/notifications
class NotificationsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications/new_appliance
  def new_appliance
    NotificationsMailer.new_appliance
  end

  def new_job
    NotificationsMailer.new_job(candidate: Candidate.first, job: Job.first)
  end
end
