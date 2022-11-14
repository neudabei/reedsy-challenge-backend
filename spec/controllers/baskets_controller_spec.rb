require 'rails_helper'

RSpec.describe 'BasketsController', :type => :request do
  before do
    Product.create(code: 'mug', name: 'Reedsy Mug', price: 600)
    Product.create(code: 'tshirt', name: 'Reedsy T-shirt', price: 1500)
    Product.create(code: 'hoodie', name: 'Reedsy Hoodie', price: 2000)

    post '/baskets', params: request_body
  end

  describe '#create' do
    let(:products_data) do
        [
          {
            code: 'mug',
            quantity: '1'
          },
          {
            code: 'tshirt',
            quantity: '1'
          },
          {
            code: 'hoodie',
            quantity: '1'
          }

        ]
    end

    let(:request_body) do
      {
        data:
        {
          type: 'basket',
          attributes: {},
          relationships: {
            products: {
              data: products_data
            }
          }
        }
      }
    end

    let(:response_body) do
      {
        data: {
          id: Basket.last.id.to_s,
          type: "baskets",
          attributes: {
            "checkout-price": checkout_price,
            "updated-at": Basket.last.updated_at.strftime('%FT%T.%LZ')
          }
        }
      }.to_json
    end

    let(:checkout_price) { '41.00' }

    it 'creates a new basket' do
      expect(Basket.count).to eq(1)
    end

    it 'adds all products from the request to the basket' do
      expect(Basket.last.products.pluck(:code)).to eq(['mug', 'tshirt', 'hoodie'])
    end

    it 'responds with status 201' do
      expect(response.status).to eq(201)
    end

    it 'responds with the total price of all products in the basket' do
      expect(response.body).to eq(response_body)
    end

    context 'when 2 mugs and 1 tshirt are added' do
      let(:checkout_price) { '27.00' }
      let(:products_data) do
        [
          {
            code: 'mug',
            quantity: '2'
          },
          {
            code: 'tshirt',
            quantity: '1'
          }
        ]
      end

      it 'responds with a total price of 27.00' do
        expect(response.body).to eq(response_body)
      end
    end

    context 'when 3 mugs and 1 tshirt are added' do
      let(:checkout_price) { '33.00' }
      let(:products_data) do
        [
          {
            code: 'mug',
            quantity: '3'
          },
          {
            code: 'tshirt',
            quantity: '1'
          }
        ]
      end

      it 'responds with a total price of 33.00' do
        expect(response.body).to eq(response_body)
      end
    end

    context 'when 2 mugs, 4 tshirts and 1 hoodie are added' do
      let(:checkout_price) { '92.00' }
      let(:products_data) do
        [
          {
            code: 'mug',
            quantity: '2'
          },
          {
            code: 'tshirt',
            quantity: '4'
          },
          {
            code: 'hoodie',
            quantity: '1'
          }
        ]
      end

      it 'responds with a total price of 92.00' do
        expect(response.body).to eq(response_body)
      end
    end

    context 'when a non existing product code is used' do
      let(:products_data) do
        [
          {
            code: 'muuug',
            quantity: '2'
          }
        ]
      end

      it 'responds with status 422' do
        expect(response.status).to eq(422)
      end

      it 'responds with an error message that lists the product codes available' do
        expect(response.body).to eq("{\"errors\":\"Please make sure the product is one of either [\\\"mug\\\", \\\"tshirt\\\", \\\"hoodie\\\"]\"}")
      end
    end

    context 'when a negative quantity is used' do
      let(:products_data) do
        [
          {
            code: 'mug',
            quantity: '-1'
          }
        ]
      end

      let(:checkout_price) { "0.00" }

      it 'ignores the product' do
        expect(response.body).to eq(response_body)
      end
    end
  end
end
