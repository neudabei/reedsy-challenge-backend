class ProductSerializer < BaseSerializer
  attributes :id, :code, :name, :price, :updated_at

  def price
    format_price(object.price)
  end
end
