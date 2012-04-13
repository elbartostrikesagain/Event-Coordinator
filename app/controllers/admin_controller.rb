class AdminController < ApplicationController

  def index
    @main_event = MainEvent.find(params[:id])
    unless can? :manage, @main_event
      flash[:error] = "We require more vespene gas."
      redirect_to @main_event
    end
  end

end