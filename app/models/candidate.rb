class Candidate < ApplicationRecord
  has_many :applications, dependent: :destroy
  has_many :jobs, through: :applications, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :cpf, presence: true
  validates :telephone, presence: true
  validates :bio, presence: true
end
