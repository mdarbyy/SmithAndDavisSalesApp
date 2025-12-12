class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_authentication

  def not_found
    error_message = "That page does not exist"
    if user_signed_in?
      redirect_to dashboard_path, danger: error_message
    else
      redirect_to new_user_session_path, danger: error_message
    end
  end
end