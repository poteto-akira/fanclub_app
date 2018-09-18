class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :set_current_user

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age])
    end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
