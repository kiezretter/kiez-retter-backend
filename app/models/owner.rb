# frozen_string_literal: true

class Owner < ApplicationRecord
  belongs_to :business
  has_one :passport
end
