class Application < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  enum status: { negada: 0, aberta: 1, aceita: 2 }
end
