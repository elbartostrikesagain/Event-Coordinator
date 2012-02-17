Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'hHm7IKlPspkg8t4fZgCKhw', 'MuC5gWUnzYNxWuNOFi099a2K1jXQnSPNXMi5L9JA'
  provider :facebook, 'consumer_key', 'consumer_secret'
end