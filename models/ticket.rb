class Ticket

  attr_reader :id, :showing_id
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
    result = Ticket.map_item(sql)
    @id = result.id
    update_discounts()
    return result
  end

  def update_discounts
    sql = "UPDATE tickets SET
        multiplier_release_date = #{multiplier_release_date()},
        multiplier_off_peak = #{multiplier_off_peak()}
        WHERE
        id = #{@id} 
     "
     SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def film
    sql = "SELECT f.* FROM films f
      INNER JOIN showings s ON f.id = s.film_id
        INNER JOIN tickets t ON s.id = t.showing_id WHERE s.id = #{@showing_id}"
    return Film.map_item(sql)
  end

  def time
    sql = "SELECT s.* FROM showings s
      INNER JOIN tickets t ON t.showing_id = s.id WHERE s.id = #{@showing_id}"
    result = Showing.map_item(sql)
    return result.showing_time
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

  def self.sell_ticket( showing, customer )
    film_type = showing.film.film_type
    person_type = customer.person_type
    pricing = Pricing.get_pricing( film_type, person_type)
    price_id = pricing.id
    price = pricing.price

    if customer.funds >= price
      customer.debit( price )
      ticket = Ticket.new( \
        'showing_id' => showing.id, \
        'customer_id' => customer.id, \
        'price_id' => price_id)
      ticket.save
      return ticket
    else return nil
    end
  end


  def multiplier_release_date
    sql = "SELECT * from films WHERE id = #{film.id}"
    result = Film.map_item(sql)
    release_date = Date.parse( result.release_date )
    now = Date.today
    days_since_release = (now - release_date).to_i
    if days_since_release > 30000 
      return 0.80
    else 
      return 1.0
    end
  end

  def multiplier_off_peak
    showing_time = time()
    showing_time = DateTime.parse( showing_time )
    peak_starts = DateTime.parse( "17:30:00" )
    if showing_time < peak_starts
      return 0.8
    else
      return 1.0
    end
  end


end 