# frozen_string_literal: true

class CleanupsController < ApplicationController

  def index
  end

  def update_business_types
    BusinessTypeUpdateJob.perform_later
    redirect_to cleanups_path, notice: 'Update job has been started.'
  end

  def check_dead_links
    LinkCheckJob.perform_later
    redirect_to cleanups_path, notice: 'Link Checker ist gestartet.'
  end

end
