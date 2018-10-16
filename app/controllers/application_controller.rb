class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_location
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:new, :create]
  # before_filterでリクエスト保存用のメソッドset_request_fromが実行されるように設定しておく
  before_action :set_request_from




  def store_location
    if (request.fullpath != "/users/sign_in" &&
      request.fullpath != "/users/sign_up" &&
      request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
      !request.xhr?) # don't store ajax calls
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

  # どこのページからリクエストが来たか保存しておく
  # 前のページに戻るためのメソッド
  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end

  # 前の画面に戻る
  def return_back
    if request.referer
      redirect_to :back and return true
    elsif @request_from
      redirect_to @request_from and return true
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
