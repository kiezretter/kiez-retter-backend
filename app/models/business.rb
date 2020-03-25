# frozen_string_literal: true

class Business < ApplicationRecord
  has_one :owner, dependent: :destroy
  has_one :trade_certificate, dependent: :destroy
  has_many :donations, dependent: :destroy
  belongs_to :business_type
  accepts_nested_attributes_for :owner, :trade_certificate
  has_one_base64_attached :favorite_place_image

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
end
