class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @users_events = Event.any_in(user_ids: [@user.id]).order_by([:starts_at, :desc]).page(params[:page]).per(20) if @user
  end
end
