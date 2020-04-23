# frozen_string_literal: true

class BusinessTypeUpdateJob < ApplicationJob
    queue_as :default
  
    def perform
        logger = Rails.logger
        logger.info 'performing BusinessTypeUpdateJob'

        business_type_mapping = Hash[*
            BusinessType.pluck(:slug, :id).flatten]

        slug_by_id = Hash[*
            BusinessType.pluck(:id, :slug).flatten]

        Business.find_each do |business|
            unless business.gmap_id.nil?
                business_type_id = BusinessTypeFinder.find_business_type(business_type_mapping, business.gmap_id)
                unless business_type_id.nil? || business_type_id == business.business_type_id
                    logger.info business.name + ' ' +
                        slug_by_id[business.business_type_id].to_s + ' -> ' + slug_by_id[business_type_id].to_s
                    business.business_type_id = business_type_id
                    business.save 
                end
            end
        end

    end
end
