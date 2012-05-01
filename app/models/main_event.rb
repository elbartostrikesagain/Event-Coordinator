class MainEvent
  include Mongoid::Document

  has_many :events
  belongs_to :user
  has_many :workers, class_name: "User", inverse_of: "registered_main_events"

  field :name, :type => String
  field :html, :type => String
  field :default_calendar_view, :type => String
  field :shifts_notice, :type => String
  field :currency, :type => String


  def first_event_date
    first_event = self.events.order_by([:starts_at, :asc]).first
    return first_event.starts_at.in_time_zone.strftime("%m/%d/%Y") unless first_event.nil? || first_event.starts_at.nil?
    Time.current.strftime("%m/%d/%Y")
  end
end
