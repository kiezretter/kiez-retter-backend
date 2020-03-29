class ImportBusinessesJob < ApplicationJob
  queue_as :default

  def perform(business_import)
    begin
      csv = CSV.parse(business_import.content.strip, headers: true)
      service = BusinessType.find_by(slug: 'service')
      business_type_mapping = Hash[*
        BusinessType
          .pluck(:slug, :id)
          .flatten
      ]
      csv.each do |row|
        row_form = row.to_hash
        b = Business.create!({
          business_type_id: business_type_mapping[row_form['business_type']],
          name: row_form['name'],
          street_address: row_form['street_address'],
          postcode: row_form['postcode'],
          city: row_form['city']
        }.merge(
          geo_params(row_form['name'], row_form['street'], row_form['city'], row_form['postcode'])
        ))
        Funding.create!(funding_type: 0, business: b, link: row_form['url'])
        Owner.create!(business: b, paypal_handle: '', email: '', nick_name: '', first_name: '', last_name: '')
      end

      business_import.imported!(csv.count)
    rescue => e
      business_import.errored!(e)
    end
  end

  private

  def geo_params(name, street, city, postcode)
    results = Geocoder.search("#{name} #{street} #{city} #{postcode}")
    coordinates = results.first.coordinates
    place_id = results.first.place_id
    { lat: coordinates[0], lng: coordinates[1], gmap_id: place_id }
  end
end
