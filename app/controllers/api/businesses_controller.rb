# frozen_string_literal: true

module Api
  class BusinessesController < ApplicationController
    respond_to :json

    def show
      @business = Business.find(params[:id])
      @owner = @business.owner
    end

    def index
      @businesses = Business.all
    end
  end
end
