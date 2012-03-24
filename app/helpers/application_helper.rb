module ApplicationHelper
  def difference(first, second)
    return 0 if first.nil? || second.nil?
    first.to_i - second.to_i
  end
  def event_admin?(main_event)
    current_user && main_event.user.id == current_user.id
  end
  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end
end
