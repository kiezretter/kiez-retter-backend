# frozen_string_literal: true

module ApplicationHelper

    def attached_image_url(attachment)
        if attachment.attached?
            ix_image_url(attachment.key)
        else
            # FIXME local urls
        end
    end
end
