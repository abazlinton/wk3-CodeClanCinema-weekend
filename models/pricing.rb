class Pricing

  
  attr_reader :id, :film_type, :price, :person_type


  def initialize(options)
    @id = options['id'] if options['id']
    @film_type = options['film_type']
    @person_type = options['person_type']
    @price = options['type']
  end


  def save
    sql = "INSERT INTO 
      pricings(
        film_type,
        person_type,
      )
      VALUES(
        '#{@film_type}',
        '#{@person_type}',
        #{@price}
      )
      RETURNING *
      "
    result = Pricing.map_item(sql)
    @id = result['id']
    return result
  end











end 