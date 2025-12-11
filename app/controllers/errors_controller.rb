class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_authentication

  def not_found
    if user_signed_in?
      redirect_to dashboard_path, danger: "That page does not exist"
    else
      redirect_to new_user_session_path, danger: "That page does not exist"
    end
  end
end