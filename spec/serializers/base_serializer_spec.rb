require 'rails_helper'

RSpec.describe BaseSerializer do
  describe '#format_price' do
    let(:product) { instance_double('Product', :product) }

    it 'returns the price with two decimals as a string' do
      serializer = BaseSerializer.new(product)
      expect(serializer.format_price(7380)).to eq('73.80')
    end
  end
end
