require './db/sql_runner'
require_relative './models/customer'
require_relative './models/film'
require 'pry-byebug'


Customer.delete_all
Film.delete_all
# test = SqlRunner.run("INSERT INTO customers(name, funds) VALUES('Alex', 9.9)")

customer1 = Customer.new('name' => 'Alex', 'funds' => '50.00')
customer1.save
puts customer1.inspect

film1 = Film.new('title' => 'The lives of others', 'price' => 12.50)
film1.save
puts film1.inspect