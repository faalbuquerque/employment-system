class CompaniesController < ApplicationController
  before_action :authenticate_collaborator!, except: %i[show]
  before_action :fetch_company
  before_action :require_same_company, except: %i[show]
  before_action :require_admin, except: %i[show]

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

  def fetch_company
    @company = Company.wich_is_for_who(collaborator_signed_in?, current_collaborator,
                                       params[:id])
  end

  def require_same_company
    return redirect_to root_path unless @company.is_same_company?(current_collaborator)
  end
end
