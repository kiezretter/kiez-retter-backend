# frozen_string_literal: true

class Business < ApplicationRecord
  has_one :owner, dependent: :destroy
  has_one :trade_certificate, dependent: :destroy
  has_many :donations, dependent: :destroy
  belongs_to :business_type
  accepts_nested_attributes_for :owner
end
