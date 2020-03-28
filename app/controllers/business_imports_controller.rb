# frozen_string_literal: true

class BusinessImportsController < ApplicationController
  def new
    @business_import = BusinessImport.new
  end

  def create
    @business_import = BusinessImport.new(business_import_params)

    if @business_import.save
      redirect_to @business_import, notice: 'Business import was successfully created.'
    else
      render :new
    end
  end
  
  def index
    @business_imports = BusinessImport.all
  end

  def show
    @business_import = BusinessImport.find(params[:id])
  end

  private

  def business_import_params
    params.require(:business_import).permit(
      :content
    )
  end
end
