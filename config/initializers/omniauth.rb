#require 'openid/store/filesystem'
#OmniAuth.config.full_host = "http://localhost:3000"

#TODO move this out of here since this is a public repo
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"]
  provider :facebook, ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"]
  #provider :openid, nil, :name => 'google_apps', :identifier => 'https://www.google.com/accounts/o8/id'
  #provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :google, "anonymous", "anonymous"
end