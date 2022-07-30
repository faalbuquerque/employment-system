class Application < ApplicationRecord
  belongs_to :candidate
  belongs_to :job
  has_many :proposals

  enum status: { denied: 0, in_progress: 1, approved: 2 }

  after_save -> () { NotificationsMailer
                     .new_appliance(candidate: self.candidate, job: self.job)
                     .deliver_now
                   }

  def is_denied?(tmp_application_params)
    !!(self.refuse_msg.nil? && 
    self.update(tmp_application_params) && 
    self.update(status: 'denied'))
  end
end
