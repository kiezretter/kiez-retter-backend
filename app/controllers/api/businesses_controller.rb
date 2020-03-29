# frozen_string_literal: true

module Api
  class BusinessesController < ApplicationController
    # FIXME This should probably depend on the current map zoom level
    ADDITIONAL_RANGE_IN_KM = 2.0 
    KM_PER_DEGREE = 111.045
    ADDITIONAL_RANGE_IN_DEGREES = ADDITIONAL_RANGE_IN_KM / KM_PER_DEGREE

    respond_to :json

    def create
      business_type = BusinessType.find_by(slug: business_params[:business_type])
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
      @businesses = Business
        .where('(verified = true OR verified IS NULL)')

      if params[:north]
        min_lat = params[:south].to_f - ADDITIONAL_RANGE_IN_DEGREES
        max_lat = params[:north].to_f + ADDITIONAL_RANGE_IN_DEGREES
        lat_range = max_lat - min_lat
        distance_lng_in_degrees = ADDITIONAL_RANGE_IN_DEGREES * Math.cos(lat_range * Math::PI / 180.0)
        min_lng = params[:west].to_f - distance_lng_in_degrees
        max_lng = params[:east].to_f + distance_lng_in_degrees
        @businesses
          .where('(lat BETWEEN ? AND  ?) AND (lng BETWEEN ? AND ?)', min_lat, max_lat, min_lng, max_lng)
      end
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
          :email, :first_name, :last_name, :salutation, :nick_name,
          :paypal_handle, owner_image: :data, id_card_image: :data
        ],
        trade_certificate_attributes: [
          trade_license_image: :data
        ]
      )
    end
  end
end
