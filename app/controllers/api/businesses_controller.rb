# frozen_string_literal: true

module Api
  class BusinessesController < ApplicationController
    respond_to :json

    def create
      business_type = BusinessType.find_by(slug: params[:business_type])
      business = Business.new(business_params.merge(business_type: business_type))
      if business.save!
        render json: business, status: :created
      else
        render json: business.errors, status: :unprocessable_entity
      end
    end

    def show
      @business = Business.find(params[:id])
      @owner = @business.owner
    end

    def index
      @businesses = Business.not_rejected
    end

    private

    def business_params
      params.require(:business).permit(
        :gmap_id, :name, :lat, :lng,
        :phone_number, :street_address, :postcode, :city,
        :business_type,
        :personal_message, :personal_thank_you,
        favorite_place_image: :data,
        owner_attributes: [
          :email, :first_name, :last_name, :salutation, :nick_name, :paypal_handle,
          owner_image: :data, id_card_image: :data
        ],
        trade_certificate_attributes: [
          trade_license_image: :data
        ]
      )
    end
  end
end
