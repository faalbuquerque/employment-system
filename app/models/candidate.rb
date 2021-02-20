class Candidate < ApplicationRecord
  has_many :applications
  has_many :jobs, through: :applications

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :cpf, presence: true
  validates :telephone, presence: true
  validates :bio, presence: true
end
