# frozen_string_literal: true

class BusinessesController < ApplicationController
  before_action :set_business, only: %i[show edit update destroy approve reject]

  def index
    @businesses = Business
                  .order(created_at: :desc)
                  .includes(:owner)

    return unless params[:business_import_id]

    @business_import = BusinessImport.find params[:business_import_id]
    @businesses = @businesses
                  .where(business_import_id: @business_import)
  end

  def show; end

  def new
    @business = Business.new
  end

  def edit; end

  def create
    @business = Business.new(params_w_geo)

    if @business.save
      redirect_to @business, notice: 'Business was successfully created.'
    else
      render :new
    end
  end

  def update
    if @business.update(params_w_geo)
      redirect_to @business, notice: 'Business was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @business.destroy
    redirect_to businesses_url, notice: 'Business was successfully destroyed.'
  end

  def approve
    @business.verified = true
    @business.save!
    redirect_to businesses_path, notice: 'Statement was approved.'
  end

  def reject
    @business.verified = false
    @business.save!
    redirect_to businesses_path, alert: 'Statement was rejected.'
  end

  def check_duplicates
    @businesses = Business.only_duplicates
  end

  private

  def set_business
    @business = Business.find(params[:id])
  end

  def params_w_geo
    business_params.merge(geo_params)
  end

  def address
    "#{params[:business][:name]} #{params[:business][:street_address]} #{params[:business][:city]} #{params[:business][:postcode]}"
  end

  def geo_params
    results = Geocoder.search(address)
    if results.one?
      coordinates = results.first.coordinates
      place_id = results.first.place_id
      { lat: coordinates[0], lng: coordinates[1], gmap_id: place_id }
    end
  end

  def business_params
    params.require(:business).permit(
      :gmap_id, :name, :lat, :lng,
      :phone_number, :street_address, :postcode, :city,
      :business_type_id, :personal_message, :personal_thank_you,
      :favorite_place_image,
      owner_attributes: %i[
        id paypal_handle first_name last_name nick_name
        email salutation owner_image id_card_image
      ],
      funding_attributes: %i[
        id link funding_type
      ]
    )
  end
end
