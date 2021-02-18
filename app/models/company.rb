class Company < ApplicationRecord
  has_many :social_networks, dependent: :destroy
  has_many :collaborators, dependent: :destroy

  validates :name, presence: true
end
