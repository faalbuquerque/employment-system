class ProposalsController < ApplicationController
  before_action :authenticate_collaborator!, only: %i[new create]
  before_action :authenticate_candidate!, only: %i[edit update]

  before_action :fetch_application

  before_action :require_same_company_collaborator, only: %i[new create]
  before_action :require_same_application_candidate, only: %i[edit update]
  before_action :check_application_denied_or_approved

  def new
    @proposal = @application.proposals.new
  end

  def create
    @proposal = Proposal.new(proposal_params.except(:id))
    message = 'Proposta enviada!'
    return redirect_to @application.job, notice: message if Proposal.can_add_proposal?(@application) && (@application.proposals << @proposal)

    flash.now[:alert] = 'Nao foi possivel enviar proposta'
    render :new
  end

  def edit
    @proposal = @application.proposals.last
  end

  def update
    @proposal = @application.proposals.last
    message = 'Resposta enviada!'
    return redirect_to @application, notice: message if update_proposal_application

    flash.now[:alert] = 'Oops, erro ao enviar resposta.'
    render :edit
  end

  private

  def proposal_params
    params.require(:proposal).permit(:message, :wage, :date_init, :status, :id)
  end

  def application_params
    params.require(:proposal).permit(:id)
  end

  def require_same_company_collaborator
    return redirect_to root_path unless @application.job.is_same_company_collaborator?(current_collaborator)
  end

  def fetch_application
    @application = Proposal.wich_is_for_who(collaborator_signed_in?, candidate_signed_in?, params)
  end

  def require_same_application_candidate
    return redirect_to root_path unless @application.candidate.eql?(current_candidate)
  end

  def check_application_denied_or_approved
    message = 'Proposta já finalizada!'
    return redirect_back(fallback_location: root_path, notice: message) if @application.denied? || @application.approved?
  end

  def update_proposal_application
    @proposal.application.update_attribute(:status, 'approved') if proposal_params[:status] == 'accepted'
    @proposal.update(proposal_params.merge(wage: @proposal.wage))
  end
end
