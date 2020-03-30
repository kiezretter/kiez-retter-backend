module Api
  class TrackingsController < ApplicationController
    def create
      tracking = Tracking.new(tracking_params)
      if tracking.save!
        render json: tracking, status: :created
      else
        render json: tracking.errors, status: :unprocessable_entity
      end
    end

    private

    def tracking_params
      params.require(:tracking).permit(
        :business_id, :action
      )
    end
  end
end
