# db/seeds.rb

puts "Seeding users..."

User.create!(
  email: "admin@example.com",
  password: "admin@",
  password_confirmation: "admin@",
  role: :admin
)

User.create!(
  email: "customer1@example.com",
  password: "customer1@",
  password_confirmation: "customer1@",
  role: :customer
)

User.create!(
  email: "customer2@example.com",
  password: "customer2@",
  password_confirmation: "customer2@",
  role: :customer
)

User.create!(
  email: "creator1@example.com",
  password: "creator1@",
  password_confirmation: "creator1@",
  role: :creator
)

User.create!(
  email: "creator2@example.com",
  password: "creator2@",
  password_confirmation: "creator2@",
  role: :creator
)

puts "Seeding done!"
