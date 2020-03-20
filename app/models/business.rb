# frozen_string_literal: true

class Business < ApplicationRecord
  has_one :owner
  has_one :trade_certificate
  has_one :passport
end
