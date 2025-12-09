class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_user_count, only: [:new, :create]

  def create
    user = User.find_by(email: sign_up_params[:email])

    if user.present?
      flash[:danger] = "An account with this email already exists"
      redirect_to new_user_registration_path
      return
    elsif sign_up_params[:email].blank?
      flash[:danger] = "Enter a email to create an account"
      redirect_to new_user_registration_path
    elsif sign_up_params[:password].blank?
      flash[:danger] = "You must enter a password to create an account"
      redirect_to new_user_registration_path
    elsif sign_up_params[:password_confirmation].blank?
      flash[:danger] = "You must confirm your password to create an account"
      redirect_to new_user_registration_path
    elsif sign_up_params[:first_name].blank? or sign_up_params[:last_name].blank?
      flash[:danger] = "You must fill out your name to create an account"
      redirect_to new_user_registration_path
    elsif sign_up_params[:password] != sign_up_params[:password_confirmation]
      flash[:danger] = "Passwords do not match"
      redirect_to new_user_registration_path
    else
      build_resource(sign_up_params)
      resource.save
      flash[:success] = "Welcome, #{sign_up_params[:first_name]}"
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    end
  end

  private

  def check_user_count
    if User.exists?
      redirect_to new_user_session_path, danger: "Contact a administrator to create an account"
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

end