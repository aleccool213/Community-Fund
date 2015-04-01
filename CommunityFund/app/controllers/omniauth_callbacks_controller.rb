class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if user_signed_in?
      # If user is already logged in, link account with facebook
      auth = request.env["omniauth.auth"]
      current_user.update(uid: auth.uid, provider: auth.provider)
      redirect_to users_path(current_user.username)
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      # User is not logged in, try to register new user
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        # User account linked with facebook exists or was successfully created
        sign_in_and_redirect @user
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        # User account creation failed, redirect to registration for manual creation
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_path
      end
    end
  end
end