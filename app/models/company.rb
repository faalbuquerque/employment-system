class Company < ApplicationRecord
  has_many :social_networks, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :jobs, dependent: :destroy

  validates :name, presence: true

  def is_same_company?(collaborator)
    !!self.collaborators.include?(collaborator)
  end

  def is_current_company_admin?(collaborator)
    !!collaborator.is_admin? && self.collaborators.include?(collaborator)
  end

end
