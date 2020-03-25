Geocoder.configure(
  lookup: :google,
  api_key: Rails.application.credentials.dig(:google_api_key)
)
