require './db/sql_runner'
require_relative './models/customer'
require 'pry-byebug'


Customer.delete_all
# test = SqlRunner.run("INSERT INTO customers(name, funds) VALUES('Alex', 9.9)")

customer1 = Customer.new('name' => 'Alex', 'funds' => '50.00')
customer1.save
pp customer1.inspect