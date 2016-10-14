require './db/sql_runner'


test = SqlRunner.run("INSERT INTO customers(name, funds) VALUES('Alex', 9.9)")