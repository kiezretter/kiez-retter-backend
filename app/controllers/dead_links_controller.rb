# frozen_string_literal: true

class DeadLinksController < ApplicationController
  before_action :set_dead_link, only: :destroy

  def index
    @dead_links = DeadLink.all.includes(:funding)
  end

  def update_business_types
    BusinessTypeUpdateJob.perform_later
    redirect_to dead_links_path, notice: 'Update job has been started.'
  end

  def destroy
    return unless @dead_link.destroy

    redirect_to dead_links_url, notice: 'Dead link was successfully destroyed.'
  end

  def check_dead_links
    LinkCheckJob.perform_later
    redirect_to dead_links_path, notice: 'Link Checker ist gestartet.'
  end

  private

  def set_dead_link
    @dead_link = DeadLink.find(params[:id])
  end
end
