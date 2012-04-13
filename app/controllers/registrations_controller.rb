class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
    @user.email = params[:user][:email]
    @user.save! if session[:omniauth].present?
  end

  def update
    @user = User.find(current_user.id)
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user][:password] = nil
      params[:user][:password_confirmation] = nil
    end
    if @user.update_attributes(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      flash[:notice] = "Profile updated successfully"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Failed to update profile"
      render "edit"
    end
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      #@user = User.first(conditions: {email: session[:omniauth][:info][:email]})
      @user = Authentication.first(conditions: {uid: session[:omniauth][:uid]}).user
      @user = User.new(email: session[:omniauth][:info][:email], name: session[:omniauth][:info][:name]) if @user.nil?
      @user.apply_omniauth(session[:omniauth])
      @user.authentications.last.save!
    end
  end
end