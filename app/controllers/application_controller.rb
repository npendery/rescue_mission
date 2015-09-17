class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user


  Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
  Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
