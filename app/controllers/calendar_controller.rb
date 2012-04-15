# calendars are not (yet) a resource in the rails sense of thw word - we
# simply have a url like calendar/index to get the one and only calendar
# this demo serves up.
class CalendarController < ApplicationController
  def index
    @main_event = MainEvent.find(params[:main_event_id])
    flash[:error] = "The calendar view has some issues and is down for maintenance when I find time."
    redirect_to main_event_event_index_path(@main_event)
    return
    @events_path = main_event_event_path(params[:main_event_id])
    @first_event_date = @main_event.first_event_date
  end

end