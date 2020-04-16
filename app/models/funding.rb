# frozen_string_literal: true

class Funding < ApplicationRecord
  belongs_to :business
  belongs_to :partner, counter_cache: :fundings_count
  has_one :dead_link, dependent: :destroy
  enum funding_type: { voucher: 0, crowd_funding: 1 }

  before_validation :create_partner_if_not_exist
  after_save :destroy_if_empty

  def create_partner_if_not_exist
    return if partner

    begin
      host = URI.parse(self.link).host
    rescue
      raise "Funding link broken: #{funding.inspect}"
    end
    home_url = 'https://' + host
    self.partner = Partner.find_or_create_by!(name: host, home_url: home_url)
    save!
  end

  private

  def destroy_if_empty
    destroy! if link.blank?
  end
end
