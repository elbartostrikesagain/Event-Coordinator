class MainEvent
  include Mongoid::Document

  has_many :events
  belongs_to :user
  has_many :workers, class_name: "User", inverse_of: "registered_main_events"

  field :name, :type => String
  field :html, :type => String
  field :default_calendar_view, :type => String
end
