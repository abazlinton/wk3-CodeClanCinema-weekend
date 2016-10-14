class Customer

  attr_reader :id, :funds
  attr_accessor :name

  def initialize(options)
    @id = options.fetch('id').to_i if options['id']
    @name = options.fetch('name')
    @funds = options.fetch('funds').to_f
  end

  def save
    sql = "INSERT INTO customers(
    name, 
    funds
    )
    VALUES(
    '#{@name}',
    #{@funds}
    )
    RETURNING *
    "
    result = SqlRunner.run(sql).first
    @id = result.fetch('id').to_i
  end

  def update
    sql = "UPDATE customers SET
      name = '#{@name}',
      funds = #{funds}
      WHERE id = #{@id}
      RETURNING *"
    result = SqlRunner.run(sql).first
    return result
  end

  def delete
    sql = "DELETE from customers WHERE id = #{@id}"
    result = SqlRunner.run(sql)
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