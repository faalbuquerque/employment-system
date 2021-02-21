class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_action
  helper_method :require_admin
  helper_method :is_admin?

  protected

  def store_action
    return unless request.get? 
    if (request.path != "/candidates/sign_in" &&
        request.path != "/candidates/sign_up" &&
        request.path != "/candidates/password/new" &&
        request.path != "/candidates/password/edit" &&
        request.path != "/candidates/confirmation" &&
        request.path != "/candidates/sign_out" &&
        !request.xhr?) # don't store ajax calls
      store_location_for(:candidate, request.fullpath)
    end
  end

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :remember_me, :company_id, :admin, :name, :cpf, :telephone, :bio]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def require_admin
    return redirect_to root_path unless is_admin?
  end
  def is_admin?
    !!(collaborator_signed_in? && current_collaborator.admin.equal?(1))
  end
end
