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
# require ''

filepath = "lib/seeds/medicine_seed.csv"

puts "Clearing up database..."
Medicine.destroy_all

CSV.foreach(filepath, headers: :first_row) do |row|
  # puts "#{row[0]}, #{row[1]}, #{row[2]}"
  name = row[0]
  batch = row[1]
  exp_date = row[2]
  mfg_date = row[3]
  manufacturer = row[4]
  serial_num = row[5]
  Medicine.create(name: name, batch: batch, exp_date: exp_date, mfg_date: mfg_date, manufacturer: manufacturer, serial_num: serial_num)
end

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

puts "Seeding database complete!"
