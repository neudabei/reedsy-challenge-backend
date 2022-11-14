require 'rails_helper'

RSpec.describe Basket do
  subject { Basket.create }

  describe '#add' do
    subject { Basket.create }
    let(:product) { Product.create(code: 'mug', name: 'Reedsy mug', price: 600) }

    it 'adds products to the basket' do
      subject.add(product)
      expect(subject.products).to eq([product])
    end
  end

  describe '#add_list_of_products' do
    before do
      Product.create(code: 'mug', name: 'Reedsy Mug', price: 600)
      Product.create(code: 'tshirt', name: 'Reedsy T-shirt', price: 1500)
      Product.create(code: 'hoodie', name: 'Reedsy Hoodie', price: 2000)
    end

    let(:product_list) do
      [
        { code: 'mug', quantity: 1 },
        { code: 'tshirt', quantity: 2 },
        { code: 'hoodie', quantity: 3 }
      ]
    end

    it 'adds a list of products to the basket' do
      subject.add_list_of_products(product_list)

      expect(subject.products.mug.count).to eq(1)
      expect(subject.products.tshirt.count).to eq(2)
      expect(subject.products.hoodie.count).to eq(3)
    end

    context 'when the list is empty' do
      let(:product_list) { [] }

      it 'adds no products to the the basket' do
        subject.add_list_of_products(product_list)
        expect(subject.products).to be_empty
      end
    end
  end
end
