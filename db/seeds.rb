# frozen_string_literal: true

puts 'Start seeding'
puts 'Creating types'

BusinessType.create!([
                       {
                         name: 'Bar',
                         slug: 'bar'
                       },
                       {
                         name: 'Club',
                         slug: 'club'
                       },
                       {
                         name: 'Späti',
                         slug: 'late_shop'
                       },
                       {
                         name: 'Restaurant',
                         slug: 'restaurant'
                       },
                       {
                         name: 'Cafe',
                         slug: 'cafe'
                       },
                       {
                         name: 'Einzelhandel',
                         slug: 'shop'
                       },
                       {
                         name: 'Dienstleistung',
                         slug: 'service'
                       }
                     ])

# puts 'Creating businesses and owners'

# 20.times do
#   b = Business.create!(
#     name: Faker::Restaurant.name,
#     lat: Faker::Address.latitude,
#     lng: Faker::Address.longitude,
#     verified: true,
#     personal_message: Faker::Lorem.paragraph(sentence_count: rand(2..20)),
#     business_type: type
#   )

#   Owner.create!(
#     business: b,
#     email: Faker::Internet.email
#   )
# end
