class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:new, :create]
  after_action  :store_location

  def store_location
    if (request.fullpath != "/users/sign_in" &&
      request.fullpath != "/users/sign_up" &&
      request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
      !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    if (session[:previous_url] == root_path)
      super
    else
      session[:previous_url] || root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age])
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:username])
   devise_parameter_sanitizer.permit(:sign_in, keys: [:name,:username])
   devise_parameter_sanitizer.permit(:account_update, keys: [:name,:username])
   devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
   devise_parameter_sanitizer.permit(:account_update, keys: [:profile])
   end
end
