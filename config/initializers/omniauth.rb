Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '27SWicWwQUb1SfoBMiAQ', '4cGwxC2wOY4sQeBI3Rjpu8ig6WeGK3ivp9OJjN4r0M'
  provider :facebook, '', ''
  #provider :openid, nil, :name => 'google_apps', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end