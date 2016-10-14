class Film

  attr_reader :id, :price
  attr_accessor :title

  def initialize(options)
    @id = options.fetch('id').to_i if options['id']
    @name = options.fetch('title')
    @price = options.fetch('price').to_f
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
  end

  def self.delete_all
    sql = "DELETE from films"
    SqlRunner.run(sql)
  end


end 