module MainEventsHelper

  def format_event_time_frame(event)
    if event.all_day == false || event.all_day == "1"
      from = event.starts_at.in_time_zone.strftime("%m/%d/%Y")
      to = event.ends_at.in_time_zone.strftime("%m/%d/%Y")
    else
      from = event.starts_at.in_time_zone.strftime("%m/%d/%Y %I:%M%p")
      to = event.starts_at.in_time_zone.strftime("%m/%d/%Y %I:%M%p")
    end
    "#{from} - #{to}"
  end

end
