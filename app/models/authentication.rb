class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user

  #Oauth
  field :provider, :type => String
  field :uid,      :type => String

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end
end