module ApplicationHelper
  def difference(first, second)
    return 0 if first.nil? || second.nil?
    first.to_i - second.to_i
  end
end
