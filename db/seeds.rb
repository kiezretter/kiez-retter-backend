# frozen_string_literal: true

puts 'Start seeding'

20.times do
  b = Business.create!(
    name: Faker::Restaurant.name,
    lat: Faker::Address.latitude,
    lng: Faker::Address.longitude,
    verified: true
  )

  Owner.create!(
    business: b,
    email: Faker::Internet.email,
    personal_message: Faker::Lorem.paragraph(sentence_count: rand(2..20))
  )
end
