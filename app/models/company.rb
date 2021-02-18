class Company < ApplicationRecord
  has_many :social_networks
  has_many :collaborators

  validates :name, presence: true
end
