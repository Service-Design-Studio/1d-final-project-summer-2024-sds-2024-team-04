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

5.times do
  Chat.create(
    chat_id: Faker::Number.number(digits:5),
    messaging_section_id: Faker::Number.number(digits:5),
    case_id: Faker::Number.number(digits:5),
    assigned_officer_id: Faker::Number.number(digits:3),
    messaging_user: Faker::Name.name,
    MOP_phone_number: Faker::PhoneNumber.phone_number,
    message: Faker::Lorem.sentence(word_count: 3),
    short_url: nil,
    topic: Faker::Lorem.sentence(word_count: 1),
    datetime: Faker::Time.between_dates(from: 1.year.ago, to: Date.today, period: :all),
    isAudited: Faker::Boolean.boolean
  )
end