class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.where(provider: omniauth['provider'], uid: omniauth['uid']).first
    if authentication && authentication.user.present?
      flash[:notice] = "Signed in successfully."
      #sign_in_and_redirect(:user, authentication.user)
      sign_in authentication.user
      redirect_to session[:return_to] || main_events_path
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :user => current_user)
      flash[:notice] = "Authentication successful."
      redirect_to edit_user_registration_path
      #redirect_to authentications_url
    else
      user = User.where(email: omniauth['info']['email']).first
      user = User.new if user.nil?
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        #sign_in_and_redirect(:user, user)
        sign_in user
        redirect_to session[:return_to] || main_events_path
      else
        session[:omniauth] = omniauth.except('extra')
        #flash[:notice] = "No account"
        redirect_to new_user_registration_url
      end
      #flash[:notice] = "No account was found matching your #{omniauth['provider']} authentication. Please (re)add this authentication type under your settings or signup for an account."
      #redirect_to new_user_session_path
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to edit_user_registration_path
    #redirect_to authentications_url
  end

  def failure
    Rails.logger.error "Oauth error. params-> #{params}"
    flash[:error] = "There has been an error logging you in. Try logging out of whatever service you are trying to login with and then try again. If all else fails use the forgot password feature and we will send you a new password."
    redirect_to new_user_session_path
  end

  protected

  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end

end