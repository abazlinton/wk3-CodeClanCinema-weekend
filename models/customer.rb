class Customer

  attr_reader :id, :funds, :person_type
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_f
    @person_type = options['person_type']
  end

  def save
    sql = "INSERT INTO customers(
    name, 
    funds,
    person_type
    )
    VALUES(
    '#{@name}',
    #{@funds},
    '#{@person_type}'
    )
    RETURNING *
    "
    result = SqlRunner.run(sql).first
    @id = result['id'].to_i
    return result
  end

  def update
    sql = "UPDATE customers SET
      name = '#{@name}',
      funds = #{@funds},
      person_type = '#{@person_type}'
      WHERE id = #{@id}
      RETURNING *"
    result = SqlRunner.run(sql).first
    return result
  end

  def delete
    sql = "DELETE from customers WHERE id = #{@id}"
    result = SqlRunner.run(sql)
  end

  def films
    sql = "SELECT f.* FROM films f 
      INNER JOIN tickets t ON f.id = t.film_id
        INNER JOIN customers c ON t.customer_id = c.id WHERE c.id = #{@id}"
    return Film.map_items(sql)
  end

  def debit(amount)
    @funds -= amount
    update
  end

  def buy_ticket(film_id)
    Ticket.sell_ticket(film_id, self)
  end

  def tickets_bought
    return films.count
  end

  def self.delete_all
    sql = "DELETE from customers"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * from customers"
    return Customer.map_items(sql)
  end

  def self.map_items(sql)
    customers = SqlRunner.run(sql)
    return customers.map {|customer| Customer.new(customer)}
  end



end 