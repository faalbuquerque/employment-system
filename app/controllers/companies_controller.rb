class CompaniesController < ApplicationController
  before_action :authenticate_collaborator!
  before_action :collaborator_company

  def edit
   @social_networks = @company.social_networks
  end

  def update
    return redirect_to @company if @company.update(company_params)

    @social_networks = @company.social_networks
    render :edit
  end

  def show
  end

  def destroy
    message = "Dados de #{@company.name} apagados com sucesso!"
    return redirect_to root_path, notice: message if @company.destroy

    render :edit
  end

  private

  def company_params
    params.require(:company).permit(:name, :logo, :address, :cnpj, :site)
  end

  def collaborator_company
    @company = current_collaborator.company
  end
end
