# frozen_string_literal: true

class BusinessImportsController < ApplicationController
  before_action :set_business_import, only: %i[show destroy]

  def new
    @business_import = BusinessImport.new
  end

  def create
    @business_import = BusinessImport.new(business_import_params)

    if @business_import.save
      ImportBusinessesJob.perform_later @business_import
      redirect_to @business_import, notice: 'Business import was successfully created.'
    else
      render :new
    end
  end
  
  def index
    @business_imports = BusinessImport.all
  end

  def show; end

  def destroy
    @business_import.destroy
    redirect_to business_imports_url, notice: 'Business import was successfully destroyed.'
  end

  private

  def set_business_import
    @business_import = BusinessImport.find(params[:id])
  end

  def business_import_params
    params.require(:business_import).permit(
      :content
    )
  end
end
