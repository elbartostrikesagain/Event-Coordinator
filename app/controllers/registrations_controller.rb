class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
    #@user.name = params[:name]
    #@user.save!
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
      @user.apply_omniauth(session[:omniauth])
      if @user.valid?
        @user.authentications.last.save!
        @user.save!
      end
    end
  end
end