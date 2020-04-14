# frozen_string_literal: true

class Business < ApplicationRecord
  has_one :owner, dependent: :destroy
  has_one :trade_certificate, dependent: :destroy
  has_many :fundings, -> { order :id }, dependent: :destroy
  accepts_nested_attributes_for :owner, :trade_certificate
  accepts_nested_attributes_for :fundings, allow_destroy: true, reject_if: -> funding { funding['link'].blank? }
  has_many :donations, dependent: :destroy
  has_many :trackings, dependent: :destroy
  belongs_to :business_type
  has_one_base64_attached :favorite_place_image
  has_many :image_references, dependent: :destroy
  belongs_to :business_import, counter_cache: :business_count, optional: true

  validates :name, :street_address, :postcode, :city, :business_type, :lat, :lng, :gmap_id, presence: true

  after_save :create_image_ref

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

  scope :only_duplicates, lambda {
    select('name, city, COUNT(*)')
      .group(:name, :city)
      .having('COUNT(*) > 1')
  }

  def verified?
    return 'PLEASE CHECK' if verified.nil? && owner.paypal_handle.present?

    verified
  end

  private

  def create_image_ref
    return unless image_references.none?

    image_references = fetch_image_details_from_google
    return if image_references.nil?

    image_references.map do |image_ref|
      ImageReference.create!(google_reference: image_ref, business: self)
    end
  end

  def fetch_image_details_from_google
    url = "https://maps.googleapis.com/maps/api/place/details/json?key=#{Rails.application.credentials.dig(:google_api_key)}&place_id=#{gmap_id}"
    response = http_request(url)
    result = JSON.parse(response.body)['result']
    return nil if result['photos'].nil?

    result['photos'][0..1].map { |photo| photo['photo_reference'] }
  end

  def http_request(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.use_ssl = true
    http.request(request)
  end
end
