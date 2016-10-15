require './db/sql_runner'
require_relative './models/customer'
require_relative './models/film'
require_relative './models/ticket'
require 'pry-byebug'

Ticket.delete_all
Customer.delete_all
# Film.delete_all

# test = SqlRunner.run("INSERT INTO customers(name, funds) VALUES('Alex', 9.9)")

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

ticket1 = Ticket.new('customer_id' => customer1.id, 'showing_id' => 2, 'price_id' => 1)
ticket1.save
puts ticket1.inspect





binding.pry
nil