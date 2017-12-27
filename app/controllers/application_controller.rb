class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :profile

  protected

  def profile
    if user_signed_in?
  	 @myprofile = current_user.id 
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :address, :address_city, :address_state, :address_zipcode])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :address, :address_city, :address_state, :address_zipcode])
  end
end