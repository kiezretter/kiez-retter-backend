# frozen_string_literal: true

class ImportBusinessesJob < ApplicationJob
  queue_as :default

  COLUMNS = %w[business_type city name postcode street_address url].freeze

  def perform(business_import)
    csv = CSV.parse(business_import.content.strip, headers: true)
    unless csv.headers
      business_import.import_error = 'Header line is missing'
      business_import.save!
      return
    end
    if (COLUMNS - csv.headers).any?
      business_import.import_error = 'Columns do not match requirements'
      business_import.save!
      return
    end

    service = BusinessType.find_by(slug: 'service')
    business_type_mapping = Hash[*
      BusinessType
                            .pluck(:slug, :id)
                            .flatten
    ]
    csv.each do |row|
      begin
        row_form = row.to_hash
        b = Business.create!({
          business_type_id: business_type_mapping[row_form['business_type']],
          name: row_form['name'],
          street_address: row_form['street_address'],
          postcode: row_form['postcode'],
          city: row_form['city'],
          business_import: business_import
        }.merge(
          geo_params(row_form['name'], row_form['street'], row_form['city'], row_form['postcode'])
        ))
        Funding.create!(funding_type: 0, business: b, link: row_form['url'])
        Owner.create!(business: b, paypal_handle: '', email: '', nick_name: '', first_name: '', last_name: '')
      rescue StandardError => e
        business_import.errored(row_form['name'], e)
      end
      business_import.imported_at = Time.now
      business_import.save!
    end
  end

  private

  def geo_params(name, street, city, postcode)
    results = Geocoder.search("#{name} #{street} #{city} #{postcode}")
    if results.one?
      result = results.first
      {
        lat: result.coordinates[0],
        lng: result.coordinates[1],
        gmap_id: result.place_id,
        city: result.city,
        postcode: result.postal_code
      }
    end
  end
end
