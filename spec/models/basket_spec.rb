require 'rails_helper'

RSpec.describe Basket do
  describe '#add' do
    subject { Basket.create }
    let(:product) { Product.create(code: 'mug', name: 'Reedsy mug', price: 600) }

    it 'adds products to the basket' do
      subject.add(product)
      expect(subject.products).to eq([product])
    end
  end
end
