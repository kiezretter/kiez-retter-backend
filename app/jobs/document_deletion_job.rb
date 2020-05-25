# frozen_string_literal: true

class DocumentDeletionJob < ApplicationJob
    queue_as :default
  
    def perform
        logger = Rails.logger
        logger.info 'performing DocumentDeletionJob'

        Business.where('verified = true').where('updated_at < ?', 7.days.ago).find_each do |business|
            logger.info business.name
            business.owner.id_card_image.destroy
            business.trade_certificate.destroy
        end
    end

end

