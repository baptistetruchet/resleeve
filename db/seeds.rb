require "open-uri"
require "yaml"

puts "Cleaning database..."
Review.destroy_all
Booking.destroy_all
Body.destroy_all
User.destroy_all


# Users
puts 'Creating users...'
file = "db/users.yml"
users = YAML.load(open(file).read)

users["users"].each do |user|
  User.create!(user)
end
puts "#{User.count} users have been created"

# Bodies
puts 'Creating bodies...'
file = "db/bodies.yml"
bodies = YAML.load(open(file).read)

bodies["bodies"].each do |body|
  b = Body.new(body)
  b.save!
end
puts "#{Body.count} bodies have been created"

# Bookings
puts 'Creating bookings...'
file = "db/bookings.yml"
bookings = YAML.load(open(file).read)

bookings["bookings"].each do |booking|
  b = Booking.new(booking)
  b.save!
end
puts "#{Booking.count} bookings have been created"
