class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  #def new
    #super
  #end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      user.last_logged_in = DateTime.now
      user.save
      flash[:success] = "Welcome, #{user.first_name}"
      sign_in_and_redirect user, event: :authentication
    else
      flash[:danger] = "Invalid email or password"
      redirect_to new_user_session_path
    end
  end

  # DELETE /resource/sign_out
  #def destroy
    #super
  #end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end