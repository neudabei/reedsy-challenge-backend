require 'rails_helper'

RSpec.describe DiscountService do
  let(:basket) { Basket.create }

  let(:mug) { Product.create(code: 'mug', name: 'Reedsy Mug', price: 600) }
  let(:tshirt) { Product.create(code: 'tshirt', name: 'Reedsy T-shirt', price: 1500) }
  let(:hoodie) { Product.create(code: 'hoodie', name: 'Reedsy Hoodie', price: 2000) }

  let(:subject) { DiscountService.new(basket) }

  context 'when there are more than 10 mugs and 1 tshirt in the basket' do
    before do
      10.times { basket.add(mug) }
      basket.add(tshirt)

      subject.apply_discounts
    end

    it 'stores the checkout amount after discount in the baskets table' do
      expect(basket.checkout_price).to eq(7380)
    end
  end

  context 'when there are more than 45 mugs and 3 tshirts in the basket' do
    before do
      45.times { basket.add(mug) }
      3.times { basket.add(tshirt) }

      subject.apply_discounts
    end

    it 'stores the checkout amount after discount in the baskets table' do
      expect(basket.checkout_price).to eq(27990)
    end
  end

  context 'when there are more than 200 mugs and 4 tshirts and 1 hoodie in the basket' do
    before do
      200.times { basket.add(mug) }
      4.times { basket.add(tshirt) }
      basket.add(hoodie)

      subject.apply_discounts
    end

    it 'stores the checkout amount after discount in the baskets table' do
      expect(basket.checkout_price).to eq(90200)
    end
  end

  context 'when no discounts apply' do
    context 'when there are 1 mug, 1 tshirt and 1 hoodie in the basket' do
      before do
        basket.add(mug)
        basket.add(tshirt)
        basket.add(hoodie)
      end

      it 'stores the checkout amount after discount in the baskets table' do
        subject.apply_discounts
        expect(basket.checkout_price).to eq(4100)
      end
    end

    context 'when there are 9 mugs and 1 tshirt in the basket' do
      before do
        9.times { basket.add(mug) }
        basket.add(tshirt)
      end

      it 'stores the checkout amount after discount in the baskets table' do
        subject.apply_discounts
        expect(basket.checkout_price).to eq(6900)
      end
    end
  end
end
