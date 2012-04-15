class AdminController < ApplicationController

  def index
    @main_event = MainEvent.find(params[:id])
    unless can? :manage, @main_event
      flash[:error] = "We require more vespene gas."
      redirect_to @main_event
    end
    @users = @main_event.workers.page(params[:page]).per(20)
  end

end