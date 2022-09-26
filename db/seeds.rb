# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Medicine.create(name: "Panadol", batch: "0001", exp_date: "2024-08-08", mfg_date: "2021-05-04", manufacturer: "gSK", serial_num: "12345")
# Medicine.create(name: "Bruffen", batch: "0003456", exp_date: "2024-08-08", mfg_date: "2021-05-04", manufacturer: "gSK", serial_num: "12345")

require 'csv'
require 'faker'

filepath_med = "lib/seeds/medicine_seed.csv"
filepath_serial = "lib/seeds/serialization_seed.csv"
filepath_offline = "lib/seeds/reports_offline_seed.csv"

puts "Clearing up database..."
Medicine.destroy_all
# User.destroy_all

CSV.foreach(filepath_med, headers: :first_row) do |row|
  # puts "#{row[0]}, #{row[1]}, #{row[2]}"
  name = row[0]
  manufacturer = row[1]
  Medicine.create(name: name, manufacturer: manufacturer)
end

puts "Medicines created!"

puts "Seeding serializations next..."
# Seeding serialization
CSV.foreach(filepath_serial, headers: :first_row) do |row|
  # puts "#{row[0]}, #{row[1]}, #{row[2]}"
  name = row[0]
  batch = row[1]
  exp_date = row[2]
  mfg_date = row[3]
  serial_num = row[4]
  serial = Serialization.create(batch: batch, exp_date: exp_date, mfg_date: mfg_date, serial_num: serial_num, medicine_id: Medicine.where(name: "#{name}")[0].id)
end

puts "Seeding pictures next..."

# Seeding pictures based on medicine name
Medicine.where(name: "Leftose").each do |medicine|
  medicine.photo.attach(io: File.open('app/assets/images/Medicine/Leftose.png'), filename: 'Leftose.png')
  medicine.save!
end

Medicine.where(name: "Zyrtec").each do |medicine|
  medicine.photo.attach(io: File.open('app/assets/images/Medicine/Zyrtec.png'), filename: 'Zyrtec.png')
  medicine.save!
end

Medicine.where(name: "Human Papillomavirus (HPV) Vaccine").each do |medicine|
  medicine.photo.attach(io: File.open('app/assets/images/Medicine/HPV.png'), filename: 'HPV.png')
  medicine.save!
end

puts "Seeding Users next..."

# Seeding Users
10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    contact: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.email,
    password: "123456"
  )
  user.save!
end

puts "Seeding reports next..."

CSV.foreach(filepath_offline, headers: :first_row) do |row|
  shop_name = row[0].to_s
  shop_location = row[1].to_s
  country = row[2].to_s
  effects = row[3].to_s
  comments = row[4].to_s
  medicine = Medicine.find_by(name: "#{row[5]}")
  user = User.offset(rand(User.count)).first
  Report.create(shop_name: shop_name, shop_location: shop_location, country: country, effects: effects, comments: comments, medicine_id: medicine.id, user_id: user.id)
end

puts "Seeding pharmacies next..."

Pharmacy.create(name: "Guardian Singapore", address: "20 Ah Hood Rd, Singapore")
Pharmacy.create(name: "Guardian Singapore", address: "38 Irrawaddy Rd, Singapore")
Pharmacy.create(name: "Thomson Retail Pharmacy", address: "339 Thomson Rd, Singapore")
Pharmacy.create(name: "Unity Novena Square", address: "238 Thomson Rd, Singapore")
Pharmacy.create(name: "Farrer Park Pharmacy", address: "1 Farrer Park Station Rd, Singapore")

puts "Seeding database complete!"
