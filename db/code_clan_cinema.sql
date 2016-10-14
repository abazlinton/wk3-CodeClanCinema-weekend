DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;


CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds NUMERIC
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price NUMERIC
);


CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id SERIAL4 REFERENCES customers(id),
  film_id SERIAL4 REFERENCES films(id)  
);