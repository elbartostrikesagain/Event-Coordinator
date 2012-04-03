class MainEvent
  include Mongoid::Document

  has_many :events
  belongs_to :user
  has_many :users

  field :name, :type => String
  field :html, :type => String
end
