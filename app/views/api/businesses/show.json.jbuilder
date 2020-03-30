# frozen_string_literal: true

json.business do
  json.business_id @business.id
  json.gmap_id @business.gmap_id
  json.name @business.name
  json.owner do
    json.first_name @owner.first_name
    json.last_name @owner.last_name
    json.nick_name @owner.nick_name
    json.image attached_image_url(@owner.owner_image)
    json.paypal @owner.paypal_handle
  end
  json.message @business.personal_message
  json.thank_you @business.personal_thank_you
  json.business_type @business.business_type.slug
  json.favorite_place_image attached_image_url(@business.favorite_place_image)
  json.address do
    json.street_address @business.street_address
    json.postcode @business.postcode
    json.city @business.city
    json.lat @business.lat
    json.lng @business.lng
  end
  json.verified @business.verified
  if @business.funding
    json.funding do
      json.funding_type @business.funding.funding_type
      json.link @business.funding.link
    end
  end
  if @business.image_references.any?
    json.image_references @business.image_references, :google_reference
  end
end
