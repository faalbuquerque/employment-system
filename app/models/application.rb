class Application < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  enum status: { denied: 0, in_progress: 1, approved: 2 }

  def is_denied?(tmp_application_params)
    !!(self.refuse_msg.nil? && 
    self.update(tmp_application_params) && 
    self.update(status: 'denied'))
  end
end
