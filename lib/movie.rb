module DefaultPoints
  def points_to_award_for(days_rented)
    1
  end
end

class RegularPrice
  include DefaultPoints

  def charge(days_rented)
    2 + (days_rented > 2 ? (days_rented - 2) * 1.5 : 0)
  end
end

class NewReleasePrice
  def charge(days_rented)
    result = 0
    result += days_rented * 3
    result
  end

  def points_to_award_for(days_rented)
    frequent_renter_points = 1
    frequent_renter_points += 1 if days_rented > 1
    frequent_renter_points
  end
end

class ChildrensPrice
  include DefaultPoints

  def charge(days_rented)
    result = 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end
end

class Movie
  attr_reader :title, :price

  def initialize(title, price)
    @title, @price = title, price
  end

  def charge(days_rented)
    price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    price.points_to_award_for(days_rented)
  end
end

