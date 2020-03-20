# frozen_string_literal: true

class Passport < ApplicationRecord
  belongs_to :owner
end
