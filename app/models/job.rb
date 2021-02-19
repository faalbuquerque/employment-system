class Job < ApplicationRecord
  belongs_to :company

  enum status: { Disponivel: 1, Indisponivel: 2 }
  enum level: { Júnior: 2, Pleno: 3, Sênior: 4 }

  validates :title_job, presence: true
  validates :description, presence: true
  validates :salary_range, presence: true
  validates :level, presence: true
  validates :requisite, presence: true
  validates :quantity, presence: true
end
