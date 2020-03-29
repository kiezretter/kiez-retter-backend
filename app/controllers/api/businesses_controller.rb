# frozen_string_literal: true

module Api
  class BusinessesController < ApplicationController

    PERCENTAL_RANGE_EXTENSION = 0.2

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
        min_lat = params[:south].to_f
        max_lat = params[:north].to_f
        add_lat = (max_lat - min_lat) * PERCENTAL_RANGE_EXTENSION / 2
        min_lat -= add_lat
        max_lat += add_lat
        min_lng = params[:west].to_f
        max_lng = params[:east].to_f
        add_lng = (max_lng > min_lng ? max_lng - min_lng : min_lng - max_lng) * PERCENTAL_RANGE_EXTENSION / 2
        min_lng -= add_lng
        max_lng += add_lng
        if max_lng > min_lng
          @businesses = @businesses
            .where('(lat BETWEEN ? AND ?) AND (lng BETWEEN ? AND ?)', min_lat, max_lat, min_lng, max_lng)
        else
          # special case around the 180th meridian east of new zealand
          @businesses = @businesses
            .where('(lat BETWEEN ? AND ?) AND ((lng BETWEEN ? AND 180) OR (lng BETWEEN -180 AND ?))', min_lat, max_lat, min_lng, max_lng)
        end
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
