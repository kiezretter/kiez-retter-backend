# frozen_string_literal: true

module ApplicationHelper

    def attached_image_url(attachment)
        if attachment.attached?
            if Rails.application.config.active_storage.service == :local
                rails_blob_url(attachment)
            else
                ix_image_url(attachment.key)
            end
        end
    end
end
