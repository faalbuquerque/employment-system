class Job < ApplicationRecord
  belongs_to :company
  has_many :applications, dependent: :destroy
  has_many :candidates, through: :applications, dependent: :destroy

  enum status: { available: 1, unavailable: 2 }
  enum level: { junior: 2, full: 3, senior: 4 }

  validates :title_job, presence: true
  validates :description, presence: true
  validates :salary_range, presence: true
  validates :level, presence: true
  validates :requisite, presence: true
  validates :quantity, presence: true

  validate :expiration_date_cannot_be_in_the_past

  def is_date_in_the_past?
    !!(date_limit.present? && date_limit < Date.today)
  end

  def expiration_date_cannot_be_in_the_past
    if is_date_in_the_past?
      errors.add(:date_limit, 'não pode ser no passado!')
    end
  end

  def is_same_company_collaborator?(collaborator)
    !!collaborator.company.jobs.include?(self)
  end

  def check_available_applications
    accepted = self.applications.where(status: 'approved').count
    if accepted >= self.quantity
      self.update_attribute(:status, 'unavailable')
      message = 'Numero de candidaturas aceitas excedido!'
    end
  end

  def check_date_valid
    self.update_attribute(:status, 'unavailable') if self.is_date_in_the_past?
  end
end
