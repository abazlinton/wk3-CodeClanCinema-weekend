class Customer

  attr_reader :id, :funds 
  attr_accessor :name, :person_type

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

    result = Customer.map_item(sql)
    @id = result.id

    return result
  end

  def update
    sql = "UPDATE customers SET
      name = '#{@name}',
      funds = #{@funds},
      person_type = '#{@person_type}'
      WHERE id = #{@id}
      RETURNING *"
    return Customer.map_item(sql)
  end

  def delete
    sql = "DELETE from customers WHERE id = #{@id}"
    result = SqlRunner.run(sql)
  end

  def films
    sql = "SELECT f.* FROM films f 
      INNER JOIN showings s ON s.film_id = f.id 
        INNER JOIN tickets t ON s.id = t.showing_id
          INNER JOIN customers c ON t.customer_id = c.id WHERE c.id = #{@id}"
    return Film.map_items(sql)
  end

  def debit(amount)
    @funds -= amount
    update
  end

  def credit(amount)
    @funds += amount
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

  def self.map_item(sql)
    return Customer.map_items(sql).first
  end



end 