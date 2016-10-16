require 'date'
class Film

  attr_reader :id, :release_date, :film_type
  attr_accessor :title

  def initialize(options) 
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @film_type = options['film_type']
    @release_date = options['release_date']
  end

  def save
    sql = "INSERT INTO films(
    title, 
    film_type,
    release_date
    )
    VALUES(
    '#{@title}',
    '#{@film_type}',
    '#{@release_date}'
    )
    RETURNING *
    "

    result = Film.map_item(sql)
    @id = result.id

    return result
  end

  def update
    sql = "UPDATE films SET
      title = '#{@title}',
      film_type = '#{@film_type}',
      release_date = '#{@release_date}'
      WHERE id = #{@id}
      RETURNING *"
    return Film.map_item(sql)
  end

  def self.most_popular_showing( film )
    sql = "SELECT s.showing_time, count(*) 
      FROM tickets t 
        INNER JOIN showings s ON t.showing_id = s.id 
          INNER JOIN films f ON s.film_id = f.id 
            WHERE f.id = #{film.id}
              GROUP BY s.showing_time
                ORDER BY count DESC"
    result = SqlRunner.run(sql)
    return result.to_a
  end


  def delete
    sql = "DELETE from films WHERE id = #{@id}"
    result = SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT c.* from customers c 
      INNER JOIN tickets t ON c.id = t.customer_id 
        INNER JOIN showings s ON t.showing_id = s.id
          INNER JOIN films f ON s.film_id = f.id WHERE f.id = #{@id}"
    return Customer.map_items(sql)
  end

  def self.get_price(film_id)
    sql = "SELECT price FROM films WHERE id = #{film_id}"
    return Film.map_item(sql).price

  end


  def tickets_sold
    return customers.count
  end

  def self.delete_all
    sql = "DELETE from films"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * from films"
    return Film.map_items(sql)
  end

  def self.map_items(sql)
    films = SqlRunner.run(sql)
    return films.map {|film| Film.new(film)}
  end

  def self.map_item(sql)
    return Film.map_items(sql).first
  end
  


end 