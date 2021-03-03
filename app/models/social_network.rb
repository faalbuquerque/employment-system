class SocialNetwork < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :url, presence: true
end
