# frozen_string_literal: true

class BusinessesController < ApplicationController
  before_action :set_business, only: %i[show edit update destroy approve reject]

  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.all
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show; end

  # GET /businesses/new
  def new
    @business = Business.new
  end

  # GET /businesses/1/edit
  def edit; end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(business_params)

    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { render :show, status: :ok, location: @business }
      else
        format.html { render :edit }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = Business.find(params[:id])
  end

  def business_params
    params.require(:business).permit(
      :gmap_id, :name, :lat, :lng,
      :phone_number, :street_address, :postcode, :city,
      :business_type,
      :personal_message, :personal_thank_you,
      owner_attributes: [:paypal_handle]
    )
  end
end
