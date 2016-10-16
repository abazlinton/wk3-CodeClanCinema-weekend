require './db/sql_runner'
require_relative './models/customer'
require_relative './models/film'
require_relative './models/ticket'
require_relative './models/showing'
require_relative './models/pricing'

require 'pry-byebug'

Ticket.delete_all
Customer.delete_all
Showing.delete_all
Film.delete_all
Pricing.delete_all


customer1 = Customer.new('name' => 'Alex', 'funds' => 20.00, 'person_type' => 'student')
customer2 = Customer.new('name' => 'Ross', 'funds' => 75.00, 'person_type' => 'adult')
customer3 = Customer.new('name' => 'Tom', 'funds' => 25.00, 'person_type' => 'senior')
customer4 = Customer.new('name' => 'Claudia', 'funds' => 100.00, 'person_type' => 'teen')
customer1.save; customer2.save; customer3.save; customer4.save

film1 = Film.new('title' => 'The lives of others', 'film_type' => 'standard', 'release_date' => '2007-02-18')
film1.save


film2 = Film.new('title' => 'Jason Bourne', 'film_type' => 'premium', 'release_date' => '2016-07-11' )
film2.save

film3 = Film.new('title' => 'Inferno', 'film_type' => 'premium', 'release_date' => '2016-10-14')
film3.save


showing1 = Showing.new('showing_time' => '20:00', 'film_id' => film1.id)
showing2 = Showing.new('showing_time' => '17:00', 'film_id' => film3.id)
showing3 = Showing.new('showing_time' => '19:30', 'film_id' => film3.id)
showing4 = Showing.new('showing_time' => '22:30', 'film_id' => film2.id)
showing5 = Showing.new('showing_time' => '15:30', 'film_id' => film1.id)
showing1.save; showing2.save; showing3.save; showing4.save; showing5.save

pricing1 = Pricing.new('film_type' => 'premium', 'person_type' => 'child', 'price' => 7)
pricing2 = Pricing.new('film_type' => 'premium', 'person_type' => 'teen', 'price' => 8)
pricing3 = Pricing.new('film_type' => 'premium', 'person_type' => 'student', 'price' => 9)
pricing4 = Pricing.new('film_type' => 'premium', 'person_type' => 'adult', 'price' => 14)
pricing5 = Pricing.new('film_type' => 'premium', 'person_type' => 'senior', 'price' => 10)
pricing6 = Pricing.new('film_type' => 'standard', 'person_type' => 'child', 'price' => 6)
pricing7 = Pricing.new('film_type' => 'standard', 'person_type' => 'teen', 'price' => 7)
pricing8 = Pricing.new('film_type' => 'standard', 'person_type' => 'student', 'price' => 8)
pricing9 = Pricing.new('film_type' => 'standard', 'person_type' => 'adult', 'price' => 10)
pricing10 = Pricing.new('film_type' => 'standard', 'person_type' => 'senior', 'price' => 8)
pricing1.save; pricing2.save; pricing3.save; pricing4.save; pricing5.save
pricing6.save; pricing7.save; pricing8.save; pricing9.save; pricing10.save

ticket1 = Ticket.sell_ticket(showing1, customer3)
ticket3 = Ticket.sell_ticket(showing2, customer1)
ticket4 = Ticket.sell_ticket(showing2, customer2)
ticket2 = Ticket.sell_ticket(showing4, customer4)
ticket5 = Ticket.sell_ticket(showing3, customer2)
ticket5 = Ticket.sell_ticket(showing5, customer1)



binding.pry
nil