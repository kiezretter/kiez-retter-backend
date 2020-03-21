# frozen_string_literal: true

class Business < ApplicationRecord
  has_one :owner
  has_one :trade_certificate
  belongs_to :business_type
  accepts_nested_attributes_for :owner
end
