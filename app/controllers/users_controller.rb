class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @users_events = Event.any_in(user_ids: [@user.id]).all if @user
  end
end
