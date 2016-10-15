class Showing

  attr_reader :id, :film_id
  attr_accessor :showing_time


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @showing_time = options['showing_time']
    @film_id = options['film_id'].to_i
  end

  
  def save
    sql = "INSERT INTO showings(
      showing_time,
      film_id
      )
      VALUES(
      '#{@showing_time}',
      #{@film_id}
      )
      RETURNING *
      "
    result = SqlRunner.run(sql).first
    @id = result['id'].to_i
    return result
  end

  def update
    sql = "UPDATE showings SET
      showing_time = '#{@showing_time}',
      film_id = #{@film_id}
      WHERE id = #{@id}
      RETURNING *
      "
      return Showing.map_item(sql)
  end


  def self.delete_all
    sql = "DELETE from showings"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * from showings"
    return Showing.map_items(sql)
  end

  def self.map_items(sql)
    showings = SqlRunner.run(sql)
    return showings.map {|showing| Showing.new(showing)}
  end

  def self.map_item(sql)
    return Showing.map_items(sql).first
  end



end