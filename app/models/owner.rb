# frozen_string_literal: true

class Owner < ApplicationRecord
  belongs_to :business
  has_one_base64_attached :owner_image
  has_one_base64_attached :id_card_image
end
