# frozen_string_literal: true

Geocoder.configure(
  google: {
    api_key: Rails.application.credentials.dig(:google_api_key)
  },
  google_places_details: {
    api_key: Rails.application.credentials.dig(:google_api_key)
  }
)
