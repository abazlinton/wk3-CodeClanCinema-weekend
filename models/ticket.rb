class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options.fetch('id').to_i if options['id']
    @customer_id = options.fetch('customer_id').to_i
    @film_id = options.fetch('film_id').to_i
  end

  def save
    sql = "INSERT INTO tickets(
    customer_id, 
    film_id
    )
    VALUES(
    #{@customer_id},
    #{@film_id}
    )
    RETURNING *
    "
    result = SqlRunner.run(sql).first
    @id = result.fetch('id').to_i
    return result
  end

  def delete
    sql = "DELETE from tickets WHERE id = #{@id}"
    result = SqlRunner.run(sql)
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

  def self.sell_ticket( film_id, customer )
    price = Film.get_price( film_id )
    if customer.funds >= price
      customer.debit( price )
      ticket = Ticket.new( 'film_id' => film_id, 'customer_id' => customer.id )
      ticket.save
    end
  end

end 