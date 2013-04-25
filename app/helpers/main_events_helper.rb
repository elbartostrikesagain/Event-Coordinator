module MainEventsHelper

  def format_event_time_frame(event)
    if event.all_day == true || event.all_day == "1"
      from = event.starts_at.in_time_zone.strftime("%m/%d/%Y")
      to = event.ends_at.in_time_zone.strftime("%m/%d/%Y")
      return "All day #{to}" if from == to
      return "#{from} - #{to}"
    elsif event.starts_at.to_date == event.ends_at.to_date
      date = event.starts_at.in_time_zone.strftime("%m/%d/%Y")
      from = event.starts_at.in_time_zone.strftime("%I:%M%p")
      to = event.ends_at.in_time_zone.strftime("%I:%M%p")
      return "#{date} #{from} - #{to}"
    else
      from = event.starts_at.in_time_zone.strftime("%m/%d/%Y %I:%M%p")
      to = event.ends_at.in_time_zone.strftime("%m/%d/%Y %I:%M%p")
      return "#{from} - #{to}"
    end
    
  end

end
