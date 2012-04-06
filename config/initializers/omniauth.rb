#require 'openid/store/filesystem'
#OmniAuth.config.full_host = "http://localhost:3000"

#TODO move this out of here since this is a public repo
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'hHm7IKlPspkg8t4fZgCKhw', 'MuC5gWUnzYNxWuNOFi099a2K1jXQnSPNXMi5L9JA'
  provider :facebook, '356355021082665', '9579c10d54db5a9750a71253c03d6b6e'
  #provider :openid, nil, :name => 'google_apps', :identifier => 'https://www.google.com/accounts/o8/id'
  #provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :google, "anonymous", "anonymous"
end