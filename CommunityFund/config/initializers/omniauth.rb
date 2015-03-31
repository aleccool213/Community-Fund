Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "APP_ID", "APP_SECRET"
  provider :twitter, "API_KEY", "API_SECRET"
end