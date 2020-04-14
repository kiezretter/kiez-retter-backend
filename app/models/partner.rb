class Partner < ApplicationRecord
  has_many :fundings, dependent: :destroy

  validates :name, :home_url, presence: true
end
