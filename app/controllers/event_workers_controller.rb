class EventWorkersController < ApplicationController
  before_filter :load_event
  before_filter :check_access

  def index
  end

  def update
    user = User.find(params[:worker_id])
    @event.users << user
    @event.main_event.workers << user unless current_user.registered_for?(@event.main_event)
    @event.save!
    redirect_to workers_for_shift_path(@event)
  end

  def destroy
    user = User.find(params[:worker_id])
    @event.users = @event.users - [user]
    @event.save!
    redirect_to workers_for_shift_path(@event)
  end

  def show    
    name = /.*#{params[:name].gsub(/\s/, ".*")}.*/i
    email = /.*#{params[:email]}.*/i
    users = User.where(name: name, email: email).not_in(event_ids: [@event.id])
    render json: {users: users}
  end

protected
  def check_access
    unless can? :manage, @event.main_event
      access_denied
    end
  end
end