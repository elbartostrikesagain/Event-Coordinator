class MainEvent
  include Mongoid::Document

  has_many :events
  belongs_to :user

  field :name, :type => String
end
