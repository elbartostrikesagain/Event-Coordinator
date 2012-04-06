class User
  include Mongoid::Document

  has_many :main_events
  has_many :events
  has_many :authentications

  belongs_to :registered_main_events, class_name: "MainEvent", inverse_of: "workers"
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

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

  #Oauth
  field :provider, :type => String
  field :uid,      :type => String

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
  # field :authentication_token, :type => String
  field :name, :type => String
  validates_presence_of :name, :email
  validates_uniqueness_of :email, :case_sensitive => false
  validate :has_authentication
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def registered_for?(event)
    if event.is_a?(Event)
      return true if Event.where(:_id => event.id).any_in(user_ids: [self.id]).all.count > 0
      false
    end
    if event.is_a?(MainEvent)
      return true if event.workers.any_in(workers: [self.id]).count == 0
    end
    false
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    self.name = omniauth['info']['name'] if name.blank?
    self.authentications << authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  #Todo: is this needed?
  def password_required?
    #(authentications.empty? || !password.blank?) && super
    authentications.empty? && password.empty?
  end

  def has_authentication
    unless (authentications.present? || password.present?)
      errors.add(:base, "Password or authentication is required.")
    end
  end

end

