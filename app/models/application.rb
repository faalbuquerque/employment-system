class Application < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  enum status: { denied: 0, in_progress: 1, approved: 2 }
end
