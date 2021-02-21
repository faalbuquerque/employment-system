class Job < ApplicationRecord
  belongs_to :company

  has_many :applications
  has_many :candidates, through: :applications

  enum status: { Disponivel: 1, Indisponivel: 2 }
  
  enum level: { Júnior: 2, Pleno: 3, Sênior: 4 }

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
      self.update_attribute(:status, 'Indisponivel')
      message = 'Numero de candidaturas aceitas excedido!'
    end
  end

  def check_date_valid
    self.update_attribute(:status, 'Indisponivel') if self.is_date_in_the_past?
  end
end
