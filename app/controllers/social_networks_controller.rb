class SocialNetworksController < ApplicationController
  before_action :authenticate_collaborator!

  def new
    @social_network = current_collaborator.company.social_networks.new
  end

  def create
    @social_network = current_collaborator.company.social_networks.new(social_network_params)
    return redirect_to edit_company_path(current_collaborator.company) if @social_network.save

    render :new
  end

  def show
    @social_network = current_collaborator.company.social_networks.find(params[:id])
  end

  def edit
    @social_network = current_collaborator.company.social_networks.find(params[:id])
  end

  def update
    @social_network = current_collaborator.company.social_networks.find(params[:id])
    return redirect_to edit_company_path(current_collaborator.company) if @social_network.update(social_network_params)

    render :edit
  end

  def destroy
    @social_network = current_collaborator.company.social_networks.find(params[:id])
    return redirect_to edit_company_path(current_collaborator.company) if @social_network.delete

    render :edit
  end

  private

  def social_network_params
    params.require(:social_network).permit(:name, :url, :company_id)
  end
end
