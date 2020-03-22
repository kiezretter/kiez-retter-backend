# frozen_string_literal: true

class TradeCertificate < ApplicationRecord
  belongs_to :business
  has_one_base64_attached :trade_license_image
end
