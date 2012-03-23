# calendars are not (yet) a resource in the rails sense of thw word - we
# simply have a url like calendar/index to get the one and only calendar
# this demo serves up.
class CalendarController < ApplicationController
  def index
    @main_event = MainEvent.find(params[:main_event_id])
    @events_path = main_event_event_path(params[:main_event_id])
  end

end