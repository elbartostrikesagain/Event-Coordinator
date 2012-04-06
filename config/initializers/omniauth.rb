require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'hHm7IKlPspkg8t4fZgCKhw', 'MuC5gWUnzYNxWuNOFi099a2K1jXQnSPNXMi5L9JA'
  provider :facebook, '', ''
  #provider :openid, nil, :name => 'google_apps', :identifier => 'https://www.google.com/accounts/o8/id'
  #provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :openid, :store => OpenID::Store::Filesystem.new('./tmp')
end