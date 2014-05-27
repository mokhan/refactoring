class Customer
  attr_reader :name

  def initialize(name, rentals = [])
    @name = name
    @rentals = rentals
  end

  def add_rental(rental)
    @rentals.push(rental)
  end

  def statement
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      # show figures for this rental
      result += "\t" + element.movie.title + "\t" + element.amount.to_s + "\n"
    end
    # add footer lines
    result += "Amount owed is #{total_amount_for(@rentals)}\n"
    result += "You earned #{total_points_for(@rentals)} frequent renter points"
    result
  end

  private

  def total_amount_for(rentals)
    rentals.inject(0) { |sum, rental| sum + rental.amount }
  end

  def total_points_for(rentals)
    rentals.inject(0) { |sum, rental| sum + rental.points }
  end
end
