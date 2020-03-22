# frozen_string_literal: true

class BusinessTypesController < ApplicationController
  before_action :set_business_type, only: %i[show edit update destroy]

  # GET /business_types
  # GET /business_types.json
  def index
    @business_types = BusinessType.all
  end

  # GET /business_types/1
  # GET /business_types/1.json
  def show; end

  # GET /business_types/new
  def new
    @business_type = BusinessType.new
  end

  # GET /business_types/1/edit
  def edit; end

  # POST /business_types
  # POST /business_types.json
  def create
    @business_type = BusinessType.new(business_type_params)

    respond_to do |format|
      if @business_type.save
        format.html { redirect_to @business_type, notice: 'Business type was successfully created.' }
        format.json { render :show, status: :created, location: @business_type }
      else
        format.html { render :new }
        format.json { render json: @business_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_types/1
  # PATCH/PUT /business_types/1.json
  def update
    respond_to do |format|
      if @business_type.update(business_type_params)
        format.html { redirect_to @business_type, notice: 'Business type was successfully updated.' }
        format.json { render :show, status: :ok, location: @business_type }
      else
        format.html { render :edit }
        format.json { render json: @business_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_types/1
  # DELETE /business_types/1.json
  def destroy
    @business_type.destroy
    respond_to do |format|
      format.html { redirect_to business_types_url, notice: 'Business type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business_type
    @business_type = BusinessType.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def business_type_params
    params.require(:business_type).permit(:name, :slug)
  end
end
