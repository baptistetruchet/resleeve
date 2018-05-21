
if Rails.env.development?
  puts "Clean Reviews table..."
  Review.destroy_all
  puts "Clean Bookings table..."
  Booking.destroy_all
  puts "Clean Bodies table..."
  Body.destroy_all
  puts "Clean Users table..."
  User.destroy_all
end



locations = ["Paris", "Bordeaux", "Nantes", "Lyon", "Marseille", "Fuveau"]
status = ["pending", "accepted", "refused", "cancelled"]


puts "Seed Database......."
puts "Create 5 User with 1..3 bodies"
5.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "azerty"
  )
  user.email = "#{user.first_name}.#{user.last_name}@gmail.com"
  user.save!

  rand(1..3).times do
    body = Body.new(
      title: Faker::Superhero.name,
      price_per_day: rand(50..750),
      location: locations.sample,
      sex: rand < 0.5 ? "F" : "M",
      description: Faker::Hipster.paragraph
    )
    body.user = user
    body.save!
  end
end

puts "Create 1..3 Booking(s) with one review for each Body"

Body.all.each do |body|

  rand(1..3).times do
    start_year = rand(2000..2017)
    start_month = rand(1..11)
    start_day = rand(1..20)
    booking = Booking.new(
      user: User.all.reject { |u| u == body.user }.sample,
      status: status.sample,
      date_in: DateTime.new(start_year, start_month, start_day),
      date_out: DateTime.new(start_year, start_month, start_day + 5),
      body: body
    )
    booking.save!

    Review.create!(
      booking: booking,
      rating: rand(0..5),
      content: Faker::Hipster.paragraph
    )
  end
end

puts "Create Alan Turing account"
User.create!(
  first_name: 'Alan',
  last_name: 'Turing',
  password: 'enigma',
  email: 'alan.turing@42.com'
)

puts "Finished!"
