DROP VIEW IF EXISTS sales_by_film;
DROP VIEW IF EXISTS revenue;
DROP VIEW IF EXISTS sales;
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
  price_id INT4 REFERENCES pricings(id),
  multiplier_release_date NUMERIC(3,2),
  multiplier_off_peak NUMERIC(3,2)

);

CREATE VIEW sales AS SELECT 
  t.id, t.showing_id, p.price AS start_price, 
    round((p.price * t.multiplier_release_date * t.multiplier_off_peak),2) AS final_price,
      round((t.multiplier_release_date * t.multiplier_off_peak),2) AS final_multiplier
      FROM tickets t INNER JOIN pricings p ON t.price_id = p.id;

CREATE VIEW revenue AS SELECT
  sum(final_price) AS total_revenue FROM sales;

CREATE VIEW sales_by_film AS SELECT 
  f.title, sum(sa.final_price) 
    FROM films f 
      INNER JOIN showings s ON f.id = s.film_id 
        INNER JOIN sales sa on s.id = sa.showing_id 
          GROUP BY f.id 
            ORDER BY f.title;


