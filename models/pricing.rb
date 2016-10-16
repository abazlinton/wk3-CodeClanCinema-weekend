class Pricing

  
  attr_reader :id, :film_type, :price, :person_type


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_type = options['film_type']
    @person_type = options['person_type']
    @price = options['price'].to_i
  end


  def save
    sql = "INSERT INTO 
      pricings(
        film_type,
        person_type,
        price
      )
      VALUES(
        '#{@film_type}',
        '#{@person_type}',
         #{@price}
      )
      RETURNING *
      "
    result = Pricing.map_item(sql)
    @id = result.id
    return result
  end


  def self.delete_all
    sql = "DELETE FROM pricings"
    return SqlRunner.run(sql)
  end

  def self.map_items(sql)
    pricings = SqlRunner.run(sql)
    return pricings.map {|pricing| Pricing.new(pricing)}
  end

  def self.map_item(sql)
    return Pricing.map_items(sql).first
  end










end 