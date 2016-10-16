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
customer1.save
puts customer1.inspect

customer2 = Customer.new('name' => 'Ross', 'funds' => 75.00, 'person_type' => 'adult')
customer2.save
puts customer2.inspect

customer3 = Customer.new('name' => 'Tom', 'funds' => 25.00, 'person_type' => 'senior')
customer3.save
puts customer3.inspect



film1 = Film.new('title' => 'The lives of others', 'film_type' => 'standard', 'release_date' => '2007-02-18')
film1.save
puts film1.inspect

film2 = Film.new('title' => 'Jason Bourne', 'film_type' => 'premium', 'release_date' => '2016-07-11' )
film2.save
puts film2.inspect

film3 = Film.new('title' => 'Inferno', 'film_type' => 'premium', 'release_date' => '2016-10-14')
film3.save
puts film3.inspect

showing1 = Showing.new('showing_time' => '20:00', 'film_id' => film1.id)
showing1.save
puts showing1.inspect

showing2 = Showing.new('showing_time' => '17:00', 'film_id' => film3.id)
showing2.save
puts showing2.inspect

pricing1 = Pricing.new('film_type' => 'premium', 'person_type' => 'student', 'price' => 10)
pricing1.save
puts pricing1.inspect

ticket1 = Ticket.new('customer_id' => customer1.id, 'showing_id' => showing1.id, 'price_id' => pricing1.id)
ticket1.save
puts ticket1.inspect

ticket2 = Ticket.new('customer_id' => customer2.id, 'showing_id' => showing2.id, 'price_id' => pricing1.id)
ticket2.save
puts ticket2.inspect

ticket2.release_date_multiplier
ticket2.off_peak_multiplier


binding.pry
nil