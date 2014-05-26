class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def amount
    movie.amount_for(days_rented)
  end

  def points
    frequent_renter_points = 1
    # add bonus for a two day new release rental
    if movie.price_code == Movie::NEW_RELEASE && days_rented > 1
      frequent_renter_points += 1
    end
    frequent_renter_points
  end
end
