class Users::PasswordsController < Devise::PasswordsController

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      flash[:success] = "A password recovery email has been sent"
      redirect_to new_session_path(resource_name)
    else
      flash.now[:danger] = resource.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end
  
  # PUT /users/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      resource.update!(last_logged_in: Time.current)
      flash[:success] = "Your password has been updated"
      sign_in(resource_name, resource)
      redirect_to root_path
    else
      flash.now[:danger] = resource.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  protected

  def resource_params
    params.require(resource_name).permit(:email, :reset_password_token, :password,:password_confirmation
    )
  end
end