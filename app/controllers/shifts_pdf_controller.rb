class ShiftsPdfController < ApplicationController
  def index
    render :layout => false
    @main_event = MainEvent.find(params[:main_event_id])
    @shifts = @main_event.events
  end
end