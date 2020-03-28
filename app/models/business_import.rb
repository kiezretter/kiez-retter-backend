require 'csv'

class BusinessImport < ApplicationRecord
  validates :content, presence: true

  after_create do
    csv = CSV.parse(self.content.strip, headers: true)
    service = BusinessType.find_by(slug: 'service')
    csv.each do |row|
      row_form = row.to_hash
      b = Business.create!({
        business_type: service,
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

    imported!(csv.count - 2)
  end

  def imported!(count)
    self.imported_at = Time.now
    self.num_imported = count
    self.save!
  end

  def imported?
    !!imported_at
  end

  private

  def geo_params(name, street, city, postcode)
    results = Geocoder.search("#{name} #{street} #{city} #{postcode}")
    coordinates = results.first.coordinates
    place_id = results.first.place_id
    { lat: coordinates[0], lng: coordinates[1], gmap_id: place_id }
  end
end
