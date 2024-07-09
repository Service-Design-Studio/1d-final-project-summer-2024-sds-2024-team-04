# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

1000.times do
  role = ['Senior Officer', 'Agent'].sample
  Employee.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    contact_number: Faker::Number.leading_zero_number(digits: 10),
    address: Faker::Address.street_address,
    pincode: Faker::Address.zip_code,
    city: Faker::Address.city,
    state: Faker::Address.state,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    date_of_hiring: Faker::Date.between(from: 5.years.ago, to: Date.today), 
    role: role
  )
  # puts "Created employee with role: #{role}"
end

# db/seeds.rb

require 'faker'

# Clear existing data
ChatTranscript.delete_all

# Create sample chat transcripts
50.times do
  ChatTranscript.create(
    messaging_session_id: Faker::Alphanumeric.alphanumeric(number: 10),
    case_id: Faker::Alphanumeric.alphanumeric(number: 10),
    assigned_queue_name: Faker::Company.industry,
    assigned_officer: Faker::Name.name,
    messaging_user: Faker::Internet.username,
    mop_phone_number: Faker::PhoneNumber.cell_phone,
    message: Faker::Lorem.paragraph(sentence_count: 3),
    short_url: Faker::Internet.url,
    attachment: Faker::File.file_name(dir: 'path/to'),
    time: Faker::Time.backward(days: 30, period: :all)
  )
end

puts "50 chat transcripts created successfully."