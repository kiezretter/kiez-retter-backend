# frozen_string_literal: true

class DeadLinksController < ApplicationController
  before_action :set_dead_link, only: :destroy

  def index
    @dead_links = DeadLink.all.includes(:funding)
  end

  def destroy
    return unless @dead_link.destroy

    redirect_to dead_links_url, notice: 'Dead link was successfully destroyed.'
  end

  private

  def set_dead_link
    @dead_link = DeadLink.find(params[:id])
  end
end
