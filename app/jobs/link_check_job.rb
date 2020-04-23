# frozen_string_literal: true

class LinkCheckJob < ApplicationJob
  queue_as :default

  def perform
    fundings = Funding.where.not(link: nil)
    fundings.each do |funding|
      check_link(funding)
      puts '.'
      sleep 1
    end
  end

  private

  def check_link(funding)
    begin
      response = http_request(funding.link)
      return if response.is_a? Net::HTTPSuccess
      return if %w[302 307 308].include? response.code
      return if DeadLink.find_by(funding: funding)
    rescue StandardError => e
      return DeadLink.create!(link: funding.link, funding: funding, error_msg: e)
    end
    DeadLink.create!(link: funding.link, funding: funding)
  end

  def http_request(url)
    uri = Addressable::URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port || uri.inferred_port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.use_ssl = true
    http.request(request)
  end
end
