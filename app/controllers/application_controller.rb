class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?




  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache, :identicon) }
  	devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :phone_no, :password, :password_confirmation, :avatar, :current_password, :avatar_cache])
  
  end

end



