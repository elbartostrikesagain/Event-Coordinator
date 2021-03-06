class User
  include Mongoid::Document

  has_many :main_events
  has_and_belongs_to_many :events
  has_many :authentications, :dependent => :destroy

  belongs_to :registered_main_events, class_name: "MainEvent", inverse_of: "workers"
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable#, :confirmable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  field :authentication_token, :type => String
  field :name, :type => String
  validates_presence_of :name, :email
  validates_uniqueness_of :email, :case_sensitive => false
  validate :has_authentication
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  before_save :ensure_authentication_token

  def registered_for?(event)
    if event.is_a?(Event)
      return true if Event.where(:_id => event.id).any_in(user_ids: [self.id]).all.count > 0
      false
    end
    if event.is_a?(MainEvent)
      return true if event.workers.where(_id: self.id).count > 0
    end
    false
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    self.name = omniauth['info']['name'] if name.blank?

    auth = Authentication.find_or_create_by(:provider => omniauth['provider'], :uid => omniauth['uid'])
    auth.user = self
    auth.save!
    self.authentications << auth
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
    (authentications.empty? || !password.nil?) && super
  end

  def has_authentication
    unless (authentications.present? || encrypted_password.present?)
      errors.add(:base, "Password or authentication is required.")
    end
  end

  def event_hours(main_event)
    time = 0
    self.events.where(main_event_id: main_event.id).each do |event|
      time += event.length.to_i
    end
    hours = (time/3600).to_i
    time -= hours * 3600
    minutes = (time/60).to_i
    {minutes: minutes, hours: hours}
  end
  
  def currency_for(main_event)
    currency = 0
    self.events.where(main_event_id: main_event.id).each do |event|
      currency += event.currency
    end
    currency
  end

  def self.emails_for_event(main_event)
    #test guy1 <test@test.com> , test2 guy <test2@test.com>
    main_event.workers.map{|worker| "#{worker.name} <#{worker.email}>"}.join(",")
  end

end

