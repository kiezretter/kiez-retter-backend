# frozen_string_literal: true

puts 'Start seeding'
puts 'Creating type'

type = BusinessType.create!(
  name: 'Bar',
  slug: 'bar'
)

puts 'Creating businesses and owners'

20.times do
  b = Business.create!(
    name: Faker::Restaurant.name,
    lat: Faker::Address.latitude,
    lng: Faker::Address.longitude,
    verified: true,
    personal_message: Faker::Lorem.paragraph(sentence_count: rand(2..20)),
    business_type: type
  )

  Owner.create!(
    business: b,
    email: Faker::Internet.email
  )
end
