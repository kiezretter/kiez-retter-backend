# frozen_string_literal: true

module Api
  class DonationsController < ApplicationController
    respond_to :json

    def create
      donation = Donation.new(donation_params)
      if donation.save!
        render json: donation, status: :created
      else
        render json: donation.errors, status: :unprocessable_entity
      end
    end

    private

    def donation_params
      params.require(:donation).permit(
        :business_id, :amount_cents
      )
    end
  end
end
