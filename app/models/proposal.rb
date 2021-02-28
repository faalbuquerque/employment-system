class Proposal < ApplicationRecord
  belongs_to :application

  validates :message, presence: true
  validates :wage, presence: true
  validates :date_init, presence: true
  validates :status, presence: true

  validate :date_init_cannot_be_in_the_past

  def is_date_in_the_past?
    !!(date_init.present? && date_init < Date.today)
  end

  def date_init_cannot_be_in_the_past
    if is_date_in_the_past?
      errors.add(:date_init, 'não pode ser no passado!')
    end
  end

  enum status: { pendent: 1, accepted: 2, rejected:3 }

  def self.can_add_proposal?(application)
    proposals = Application.find(application.id).proposals
    !!(proposals.empty? || proposals.last.rejected?)
  end

  def  self.wich_is_for_who(collaborator, candidate, tmp_params)
    if collaborator
      Application.find(tmp_params[:proposal][:id])
     elsif candidate
      Proposal.find(tmp_params[:id]).application
     end
  end
end
