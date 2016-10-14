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
  


end 