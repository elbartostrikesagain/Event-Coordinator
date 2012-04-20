# calendars are not (yet) a resource in the rails sense of thw word - we
# simply have a url like calendar/index to get the one and only calendar
# this demo serves up.
class CalendarController < ApplicationController
  def index
    @main_event = MainEvent.find(params[:main_event_id])
    #flash[:error] = "The calendar view has some issues and is down for maintenance when I find time."
    #redirect_to main_event_event_index_path(@main_event)
    #return
    @events_path = calendar_events_path(params[:main_event_id])
    @first_event_date = @main_event.first_event_date
  end

  def events
    @main_event = MainEvent.find(params[:main_event_id])
    @events = Event.scoped
    @events = @events.where(main_event_id: params[:main_event_id]).order_by([:starts_at, :asc]).page(params[:page]).per(20)
    respond_to do |format|
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

end