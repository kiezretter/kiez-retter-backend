# frozen_string_literal: true

module GeocoderHelper

    def maybe_get_business_type(business_type_mapping, place_id)
        if place_id.nil?
          return nil
        end
        response = Geocoder.search(place_id, lookup: :google_places_details)
        place_types = response.first.types
        if place_types.nil? || place_types.length == 0
          return nil
        end
        # https://developers.google.com/places/web-service/supported_types
        case place_types.first
        when 'bar'
          return business_type_mapping['bar']
        when 'cafe'
          return business_type_mapping['cafe']
        when 'convenience_store', 'liquor_store'
          return business_type_mapping['late_shop']
        when 'bakery', 'clothing_store', 'drugstore', 'florist', 'home_goods_store', 'shoe_store', 'store'
          return business_type_mapping['shop']
        when 'night_club'
          return business_type_mapping['club']
        when 'restaurant'
          return business_type_mapping['restaurant']
        when 'hair_care', 'laundry'
          return business_type_mapping['service']
        else
          return nil
        end
    end

end