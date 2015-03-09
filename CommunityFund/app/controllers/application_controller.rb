class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :email
  end

  def authenticate_admin!
    authenticate_user!
    if not current_user.admin?
      if request.format.js?
        render json: {}, status: 401
      else
        redirect_to dashboard_path
      end
    end
  end

end
