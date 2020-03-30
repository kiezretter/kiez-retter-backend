class Tracking < ApplicationRecord
  belongs_to :business, optional: true
end
