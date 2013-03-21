class AdminController < ApplicationController

  def index
    @main_event = MainEvent.find(params[:id])
    unless can? :manage, @main_event
      access_denied
    end
    @users = @main_event.workers.page(params[:page]).per(20)

    current_count = 0
    @main_event.events.each {|e| current_count += e.users.count} #TODO- bad performance/scaling
    @worker_count_summary = "#{current_count.to_i}/#{@main_event.events.sum(:num_users).to_i}"
  end

end