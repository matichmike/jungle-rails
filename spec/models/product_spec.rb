require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    

    context "Product validation tests" do
      before do
      @category = Category.create(name:"Beverages")
      category_id = @category.id
      end
  
      after do
        puts subject.errors.full_messages
      end
      
      it "has valid attributes" do
      subject = Product.new(name: "test", price: 100, quantity: 10, category_id: @category.id)
      
        expect(subject).to be_valid
      end
  
      it "invalid if name is not available" do
        
        subject.name = nil
        expect(subject).to be_invalid
      end
  
      it "invalid if price is not available" do
        
        subject.price_cents = nil
        expect(subject).to be_invalid
      end
  
      it "invalid if quantity is not available" do
        
        subject.quantity = nil
        expect(subject).to be_invalid
      end
  
      it "invalid if category is not available" do
        
        subject.category_id = nil
      expect(subject).to be_invalid
      end
    end
  end
end
