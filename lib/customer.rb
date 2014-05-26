class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def statement
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      # show figures for this rental
      result += "\t" + element.movie.title + "\t" + amount_for(element).to_s + "\n"
    end
    # add footer lines
    result += "Amount owed is #{total_amount_for(@rentals)}\n"
    result += "You earned #{total_points_for(@rentals)} frequent renter points"
    result
  end

  private

  def total_amount_for(rentals)
    rentals.inject(0) { |sum, rental| sum + amount_for(rental) }
  end

  def total_points_for(rentals)
    rentals.inject(0) { |sum, rental| sum + points_for(rental) }
  end

  def amount_for(rental)
    rental.amount
  end

  def points_for(rental)
    rental.points
  end
end
