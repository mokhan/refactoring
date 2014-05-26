class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end

  def charge(days_rented)
    price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    frequent_renter_points = 1
    # add bonus for a two day new release rental
    if price_code == Movie::NEW_RELEASE && days_rented > 1
      frequent_renter_points += 1
    end
    frequent_renter_points
  end

  private

  def price
    case price_code
    when Movie::REGULAR
      RegularPrice.new
    when Movie::NEW_RELEASE
      NewReleasePrice.new
    when Movie::CHILDRENS
      ChildrensPrice.new
    end
  end
end

class RegularPrice
  def charge(days_rented)
    result = 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
    result
  end
end

class NewReleasePrice
  def charge(days_rented)
    result = 0
    result += days_rented * 3
    result
  end
end

class ChildrensPrice
  def charge(days_rented)
    result = 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end
end
