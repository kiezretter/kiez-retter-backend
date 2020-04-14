# frozen_string_literal: true

class Funding < ApplicationRecord
  belongs_to :business
  has_one :dead_link, dependent: :destroy
  enum funding_type: { voucher: 0, crowd_funding: 1 }

  after_save :destroy_if_empty

  def destroy_if_empty
    destroy! if link.blank?
  end
end
