class Basket < ApplicationRecord
  has_many :checkouts
  has_many :products, through: :checkouts

  def add(product)
    products << product
  end
end
