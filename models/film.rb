class Film

  attr_reader :id, :price
  attr_accessor :title

  def initialize(options) 
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_f
  end

  def save
    sql = "INSERT INTO films(
    title, 
    price
    )
    VALUES(
    '#{@title}',
    #{@price}
    )
    RETURNING *
    "
    result = SqlRunner.run(sql).first
    @id = result.fetch('id').to_i
    return result
  end

  def update
    sql = "UPDATE films SET
      title = '#{@title}',
      price = #{@price}
      WHERE id = #{@id}
      RETURNING *"
    result = SqlRunner.run(sql).first
    return result
  end

  def delete
    sql = "DELETE from films WHERE id = #{@id}"
    result = SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT c.* from customers c 
      INNER JOIN tickets t ON c.id = t.customer_id 
        INNER JOIN films f ON t.film_id = f.id WHERE f.id = #{@id}"
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