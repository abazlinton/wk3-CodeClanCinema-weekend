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
  end

  def self.delete_all
    sql = "DELETE from tickets"
    SqlRunner.run(sql)
  end


end 