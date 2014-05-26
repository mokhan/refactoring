require "spec_helper"

describe Customer do
  let(:name) { 'george' }
  let(:customer) { Customer.new(name) }

  describe "#statement" do
    context "when no activity has taken place" do
      it "produces an empty statement" do
        statement = customer.statement
        statement.should == "Rental Record for #{name}\nAmount owed is 0\nYou earned 0 frequent renter points"
      end
    end

    context "when a regular movie is rented" do
      let(:movie) { Movie.new('star wars', Movie::REGULAR) }

      before { customer.add_rental(Rental.new(movie, days_rented)) }

      context "for one day" do
        let(:days_rented) { 1 }

        it "produces the correct statement" do
          customer.statement.should == "Rental Record for #{name}\n\tstar wars\t2\nAmount owed is 2\nYou earned 1 frequent renter points"
        end
      end

      context "for more than two days" do
        let(:days_rented) { 3 }

        it "produces the correct statement" do
          customer.statement.should == "Rental Record for #{name}\n\tstar wars\t3.5\nAmount owed is 3.5\nYou earned 1 frequent renter points"
        end
      end
    end

    context "when a new release is rented" do
      let(:movie) { Movie.new('star wars', Movie::NEW_RELEASE) }

      before { customer.add_rental(Rental.new(movie, 1)) }

      it "produces the correct statement" do
        customer.statement.should == "Rental Record for #{name}\n\tstar wars\t3\nAmount owed is 3\nYou earned 1 frequent renter points"
      end
    end

    context "when a childrens movie is rented" do
      let(:movie) { Movie.new('star wars', Movie::NEW_RELEASE) }

      before { customer.add_rental(Rental.new(movie, days_rented)) }

      context "for one day" do
        let(:days_rented) { 1 }

        it "produces the correct statement" do
          customer.statement.should == "Rental Record for #{name}\n\tstar wars\t3\nAmount owed is 3\nYou earned 1 frequent renter points"
        end
      end

      context "for more than 3 days" do
        let(:days_rented) { 4 }

        it "produces the correct statement" do
          customer.statement.should == "Rental Record for #{name}\n\tstar wars\t12\nAmount owed is 12\nYou earned 2 frequent renter points"
        end
      end
    end

    context "when a bunch of movies are rented" do
      it "produces the correct statement" do
        customer.add_rental(Rental.new(Movie.new("Star War I", Movie::CHILDRENS), 5))
        customer.add_rental(Rental.new(Movie.new("Star War II", Movie::REGULAR), 5))
        customer.add_rental(Rental.new(Movie.new("Star War III", Movie::NEW_RELEASE), 5))
        customer.statement.should == "Rental Record for george\n\tStar War I\t4.5\n\tStar War II\t6.5\n\tStar War III\t15\nAmount owed is 26.0\nYou earned 4 frequent renter points"
      end
    end
  end
end
