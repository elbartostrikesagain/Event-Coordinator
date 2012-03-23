module ApplicationHelper
  def difference(first, second)
    return 0 if first.nil? || second.nil?
    first.to_i - second.to_i
  end
  def event_admin?(main_event)
    current_user && main_event.user.id == current_user.id
  end
end
