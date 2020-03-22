# frozen_string_literal: true

json.business do 
  json.business_id @business.id
  json.gmap_id @business.gmap_id
  json.nick_name @owner.nick_name
  json.message @business.personal_message
  json.thank_you @business.personal_thank_you
  json.paypal @owner.paypal_handle
  json.business_type @business.business_type.slug
  json.favorite_place_image attached_image_url(@business.favorite_place_image)
  json.owner_image attached_image_url(@owner.owner_image)
end