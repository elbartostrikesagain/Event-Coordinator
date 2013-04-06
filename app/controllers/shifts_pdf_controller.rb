class ShiftsPdfController < ApplicationController
  def index
    @main_event = MainEvent.find(params[:main_event_id])
    @shifts = @main_event.events
    render :layout => false
  end
end