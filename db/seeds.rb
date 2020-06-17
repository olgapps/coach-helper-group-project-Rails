# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(email: 'user@user.com', team: 'User Team') do |user|
    user.password = 'Haslo123.'
  end

# Player.find_or_create(name: "Adam", surname: "Nowak", bith_date: "2000-01-01", trained_in_club: true, trained_in_country: true, european: true, red_cards: 0, yellow_cards: 0)
# Player.find_or_create(name: "Piotrek", surname:"Kowalski", bith_date: "1988-10-22", trained_in_club: false, trained_in_country: true, european: true, red_cards: 1, yellow_cards: 0)
# Player.find_or_create(name: "Marek", surname:"Walas", bith_date: "1948-09-21", trained_in_club: true, trained_in_country: false, european: true, red_cards: 1, yellow_cards: 0)
