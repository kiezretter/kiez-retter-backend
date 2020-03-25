# frozen_string_literal: true

class Business < ApplicationRecord
  has_one :owner, dependent: :destroy
  has_one :trade_certificate, dependent: :destroy
  has_one :funding
  accepts_nested_attributes_for :owner, :trade_certificate, :funding
  has_many :donations, dependent: :destroy
  has_one :funding
  belongs_to :business_type
  has_one_base64_attached :favorite_place_image
  has_many :image_references

  after_create :create_image_ref

  scope :not_yet_verified, lambda {
    where(verified: nil)
  }

  scope :verified, lambda {
    where(verified: true)
  }

  scope :rejected, lambda {
    where(verified: false)
  }

  scope :not_rejected, lambda {
    where('verified = true OR verified IS NULL')
  }

  def verified?
    return 'PLEASE CHECK' if verified.nil?

    verified
  end

  private

  def create_image_ref
    fetch_image_details_from_google.map do |image_ref|
      ImageReference.create!(google_reference: image_ref, business: self)
    end
  end

  def fetch_image_details_from_google
    url = "https://maps.googleapis.com/maps/api/place/details/json?key=#{Rails.application.credentials.dig(:google_api_key)}&place_id=#{gmap_id}"
    response = http_request(url)
    JSON.parse(response.body)['result']['photos'][0..1].map { |photo| photo['photo_reference'] }
  end

  def http_request(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.use_ssl = true
    http.request(request)
  end
end
