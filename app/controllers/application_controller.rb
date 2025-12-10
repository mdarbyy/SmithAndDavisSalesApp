class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :authenticate_user!
  before_action :check_authentication

  private

  def check_authentication
    return if user_signed_in? or devise_controller?
    flash[:danger] = "You must be logged in to access the app"
    redirect_to new_user_session_path
  end
end