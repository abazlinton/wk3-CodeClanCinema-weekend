


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

  def self.delete_all
    sql = "DELETE from customers"
    SqlRunner.run(sql)
  end


end 