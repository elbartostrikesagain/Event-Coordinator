class SessionsController < ApplicationController

  def create
    binding.pry
    auth = request.env["omniauth.auth"]
    user = User.first(conditions: { provider: auth["provider"], uid: auth["uid"] }) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def new
    
  end

end
