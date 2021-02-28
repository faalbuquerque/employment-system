class CollaboratorsController < Devise::RegistrationsController
  before_action :authenticate_collaborator!, only: %i[index]
  before_action :create_company, only: %i[create]

  def index
    return redirect_to new_collaborator_session_path unless collaborator_signed_in?
  end

  def create_company
    email = params[:collaborator][:email]
    company_name = email.blank? ? '' : email.split('@').last.split('.').first 

    unless Company.exists?(name: company_name) 
      @company = Company.create(name: company_name)

      params[:collaborator][:company_id] = @company.id
      params[:collaborator][:admin] = 1
    else
      params[:collaborator][:company_id] = Company.find_by(name: company_name).id
    end
  end

  private

  def after_sign_up_path_for(resource)
    collaborators_path
  end
end
