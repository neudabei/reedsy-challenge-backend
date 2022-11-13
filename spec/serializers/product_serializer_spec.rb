require 'rails_helper'

RSpec.describe ProductSerializer do
  describe '#price' do
    it 'returns the price with two decimals as a string' do
      product = Product.create(code: 'mug', name: 'Reedsy Mug', price: 600)
      serializer = ProductSerializer.new(product)
      expect(serializer.price).to eq('6.00')
    end
  end
end
