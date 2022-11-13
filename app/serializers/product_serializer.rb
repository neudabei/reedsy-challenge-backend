class ProductSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :price, :updated_at
end
