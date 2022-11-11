require 'rails_helper'

RSpec.describe 'ProductsController', :type => :request do
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
end
