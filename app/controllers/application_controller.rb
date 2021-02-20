class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :require_admin
  helper_method :is_admin?

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :remember_me, :company_id, :admin]
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
