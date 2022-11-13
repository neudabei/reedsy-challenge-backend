require 'rails_helper'

RSpec.describe 'ProductsController', :type => :request do
  let(:product) { Product.create(code: 'mug', name: 'Reedsy Mug', price: 600) }

  describe '#index' do
    it 'returns the full list of products with attributes' do
      product = Product.create(code: 'mug', name: 'Reedsy Mug', price: 600)
      expected_response = {
        data:
        [
          {
            id: product.id.to_s,
            type: 'products',
            attributes:
            {
              code: 'mug',
              name: 'Reedsy Mug',
              price: '6.00',
              "updated-at": product.updated_at
            }
          }
        ]
      }

      get '/products'

      expect(response.body).to eq(expected_response.to_json)
      expect(response).to have_http_status(:success)
    end

    context 'when no products exist' do
      it 'returns an empty list of items' do
        get '/products'

        expect(response.body).to eq({ data: [] }.to_json)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#update' do
    let(:request_body) {
      { data:
        {
          id: product.id.to_s,
          type: 'products',
          attributes:
          {
            code: 'mug',
            name: 'Reedsy Mug',
            price: '800',
          }
        }
      }
    }

    let(:response_body) {
      {
        "data": {
          "id": product.id.to_s,
          "type": "products",
          "attributes": {
            "code": "mug",
            "name": "Reedsy Mug",
            "price": "8.00",
            "updated-at": product.reload.updated_at.strftime('%FT%T.%LZ')
          }
        }
      }.to_json
    }

    before do
      patch "/products/#{product.id}", params: request_body
    end

    it 'updates the product with the new price' do
      expect(product.reload.price).to eq(800)
    end

    it 'responds with a 200' do
      expect(response.status).to eq(200)
    end

    it 'responds with the updated resource' do
      expect(response.body).to eq(response_body)
    end

    context 'when no product with that id can be found' do
      before do
        patch "/products/#{Product.last.id + 1}", params: request_body
      end

      it 'responds with a 404' do
        expect(response.status).to eq(404)
      end
    end
  end
end
