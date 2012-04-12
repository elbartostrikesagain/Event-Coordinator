class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :main_event
  has_and_belongs_to_many :users


  #scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  #scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
  scope :before, lambda {|end_time| where(:ends_at.lt => Event.format_date(end_time)) }
  scope :after, lambda {|start_time| where(:starts_at.gt => Event.format_date(start_time)) }

  field :title, :field => String
  field :starts_at, :field => DateTime
  field :ends_at, :field => DateTime
  field :all_day, :field => Boolean
  field :description, :field => String
  field :num_users, :field => Integer

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => (starts_at).to_datetime.rfc822,
      :end => (ends_at).to_datetime.rfc822,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.main_event_event_path(self.main_event.id, id)
    }

  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  def needs_workers?
    return self.num_users.to_i > self.users.count
  end

end
