require './db/sql_runner'
require_relative './models/customer'
require_relative './models/film'
require_relative './models/ticket'
require 'pry-byebug'

Ticket.delete_all
Customer.delete_all
Film.delete_all

# test = SqlRunner.run("INSERT INTO customers(name, funds) VALUES('Alex', 9.9)")

customer1 = Customer.new('name' => 'Alex', 'funds' => '50.00')
customer1.save
puts customer1.inspect

customer2 = Customer.new('name' => 'Ross', 'funds' => '75.00')
customer2.save
puts customer2.inspect

customer3 = Customer.new('name' => 'Tom', 'funds' => '25.00')
customer3.save
puts customer3.inspect



film1 = Film.new('title' => 'The lives of others', 'price' => 12.50)
film1.save
puts film1.inspect

film2 = Film.new('title' => 'Jason Bourne', 'price' => 14.50)
film2.save
puts film2.inspect

film3 = Film.new('title' => 'There will be blood', 'price' => 11.60)
film3.save
puts film3.inspect

ticket1 = Ticket.new('customer_id' => customer1.id, 'film_id' => film1.id)
ticket1.save
puts ticket1.inspect

ticket2 = Ticket.new('customer_id' => customer2.id, 'film_id' => film2.id)
ticket2.save
puts ticket2.inspect

ticket3 = Ticket.new('customer_id' => customer3.id, 'film_id' => film3.id)
ticket3.save
puts ticket3.inspect

ticket4 = Ticket.new('customer_id' => customer1.id, 'film_id' => film1.id)
ticket4.save
puts ticket4.inspect



binding.pry
nil