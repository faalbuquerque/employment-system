class ProposalsController < ApplicationController
  before_action :authenticate_collaborator!
  before_action :fetch_application
  before_action :require_same_company_collaborator

  def new
    @proposal = @application.proposals.new
  end

  def create
    @proposal = @application.proposals.new(proposal_params)

    message = 'Proposta enviada!'
    return redirect_to @application.job, notice: message if Proposal.can_add_proposal?(@application) && @proposal.save

    flash.now[:alert] = 'Nao foi possivel enviar proposta'
    render :new
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
    @application = Application.find(application_params[:id])
  end
end
