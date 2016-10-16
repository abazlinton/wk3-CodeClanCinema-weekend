DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS showings;
DROP TABLE IF EXISTS pricings;
DROP TABLE IF EXISTS films;


CREATE TYPE person_types AS ENUM ('adult','child', 'teen', 'student', 'senior');
CREATE TYPE film_types AS ENUM ('premium','standard');


CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  --- Better to specify 
  funds NUMERIC(20,2),
  person_type person_types
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  film_type film_types,
  release_date date 
);


CREATE TABLE pricings(
  id SERIAL4 UNIQUE,
  film_type film_types NOT NULL,
  person_type person_types NOT NULL,
  price NUMERIC(5,2),
  PRIMARY KEY (film_type, person_type)
);

CREATE TABLE showings(
  id SERIAL4 PRIMARY KEY,
  showing_time time,
  film_id INT4 REFERENCES films(id)
);

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id),
  showing_id INT4 REFERENCES showings(id),
  price_id INT4 REFERENCES pricings(id)
);


