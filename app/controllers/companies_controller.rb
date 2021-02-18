class CompaniesController < ApplicationController
  before_action :authenticate_collaborator!

  def edit
   @company = current_collaborator.company
   @social_networks = @company.social_networks
  end

  def update
    @company = current_collaborator.company
    return redirect_to @company if @company.update(company_params)

    @social_networks = @company.social_networks
    render :edit
  end

  def show
    @company = current_collaborator.company
  end

  private

  def company_params
    params.require(:company).permit(:name, :logo, :address, :cnpj, :site)
  end
end
