class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @showing_id = options['showing_id'].to_i
    @price_id = options['price_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets(
    customer_id, 
    showing_id,
    price_id
    )
    VALUES(
    #{@customer_id},
    #{@showing_id},
    #{@price_id}
    )
    RETURNING *
    "
    result = SqlRunner.run(sql).first
    @id = result['id'].to_i
    return result
  end

  def delete
    sql = "DELETE from tickets WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def film
    sql = "SELECT * from films f
      INNER JOIN showings s ON f.id = s.film_id
        INNER JOIN tickets t ON s.id = t.showing_id WHERE t.id = #{@id}"
    return Film.map_item(sql)
  end

  def customer
    sql = "SELECT * FROM customers c
      INNER JOIN tickets t ON c.id = t.customer_id
        WHERE t.id = #{@id}"
      return Customer.map_item(sql)
    end


  def self.delete_all
    sql = "DELETE from tickets"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * from tickets"
    return Ticket.map_items(sql)
  end

  def self.map_items(sql)
    tickets = SqlRunner.run(sql)
    return tickets.map {|ticket| Ticket.new(ticket)}
  end

  def self.map_item(sql)
    return Ticket.map_items(sql).first
  end

  def self.sell_ticket( film_id, customer )
    price = Film.get_price( film_id )
    if customer.funds >= price
      customer.debit( price )
      ticket = Ticket.new( 'film_id' => film_id, 'customer_id' => customer.id )
      ticket.save
      return ticket
    else return nil
    end

  end

end 