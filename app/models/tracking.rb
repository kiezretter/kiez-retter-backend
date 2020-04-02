# frozen_string_literal: true

class Tracking < ApplicationRecord
  belongs_to :business, optional: true
end
