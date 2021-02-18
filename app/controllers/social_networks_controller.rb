class SocialNetworksController < ApplicationController
  before_action :authenticate_collaborator!
  before_action :find_social_networks, only: %i[show edit update destroy] 

  def new
    @social_network = current_collaborator.company.social_networks.new
  end

  def create
    @social_network = current_collaborator.company.social_networks.new(social_network_params)
    return redirect_to edit_company_path(current_collaborator.company) if @social_network.save

    render :new
  end

  def show
  end

  def edit
  end

  def update
    return redirect_to edit_company_path(current_collaborator.company) if @social_network.update(social_network_params)

    render :edit
  end

  def destroy
    return redirect_to edit_company_path(current_collaborator.company) if @social_network.delete

    render :edit
  end

  private

  def social_network_params
    params.require(:social_network).permit(:name, :url, :company_id)
  end

  def find_social_networks
    @social_network = current_collaborator.company.social_networks.find(params[:id])
  end
end
