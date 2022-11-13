class ProductSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :price, :updated_at

  def price
    sprintf("%.2f", object.price / 100)
  end
end
