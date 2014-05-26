require "spec_helper"

describe Customer do
  describe "#statement" do
    it "produces a statement" do
      customer = Customer.new('george')
      customer.statement.should_not be_nil
    end
  end
end
