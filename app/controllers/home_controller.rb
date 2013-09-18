class HomeController < ApplicationController
  def index
    @users = User.all
    @hours = get_hours
  end

  protected

  def get_hours
    cached_hours = Rails.cache.read(:total_hours)
    return cached_hours if cached_hours.present?
    
    total_hours = Event.total_hours
    
    Rails.cache.write(:total_hours, total_hours, expires_in: 1.day)
    
    total_hours
  end
end
