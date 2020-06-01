require 'rails_helper'

RSpec.describe Product, type: :model do
  subject = Product.new(name: "test", price: 100, quantity: 10)
  describe 'Validations' do
    before(:each) do
      @category = Category.new(id:1)
      subject.category = @category
    end

    after(:each) do
      puts subject.errors.full_messages
    end

    it "has valid attributes" do
      # subject = Product.new(name: "test", price: 100, quantity: 10, category: @category)
      expect(subject).to be_valid
    end

    it "invalid if name is not available" do
      # subject = Product.new(name: "test", price: 100, quantity: 10, category: @category)
      subject.name = nil
      expect(subject).to be_invalid
    end

    it "invalid if price is not available" do
      # subject = Product.new(name: "test", price: 100, quantity: 10, category: @category)
      subject.price_cents = nil
      expect(subject).to be_invalid
    end

    it "invalid if quantity is not available" do
      # subject = Product.new(name: "test", price: 100, quantity: 10, category: @category)
      subject.quantity = nil
      expect(subject).to be_invalid
    end

    it "invalid if category is not available" do
      # subject = Product.new(name: "test", price: 100, quantity: 10, category: @category)
      subject.category = nil
    expect(subject).to be_invalid
    end
  end
end
