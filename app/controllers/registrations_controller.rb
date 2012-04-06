class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
    #@user.name = params[:name]
    #@user.save!
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