# frozen_string_literal: true

class BusinessType < ApplicationRecord
  has_many :businesses, dependent: :destroy
end
