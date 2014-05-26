class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def amount
    movie.charge(days_rented)
  end

  def points
    movie.frequent_renter_points(days_rented)
  end
end
