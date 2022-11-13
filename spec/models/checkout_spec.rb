require 'rails_helper'

RSpec.describe Checkout do
  describe 'callbacks' do
    let(:basket) { Basket.create }
    let(:product_one) { Product.create(code: 'mug', name: 'Reedsy Mug', price: 800) }
    let(:product_two) { Product.create(code: 'tshirt', name: 'Reedsy Tshirt', price: 600) }

    it 'sets the price of all products in a basket' do
      basket.products << product_one
      basket.products << product_two
      
      expect(basket.checkout_price).to eq(1400)
    end
  end
end
