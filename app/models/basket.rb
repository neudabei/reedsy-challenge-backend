class Basket < ApplicationRecord
  has_many :checkouts
  has_many :products, through: :checkouts

  def add(product)
    products << product
  end

  def add_list_of_products(product_list)
    product_list.each do |item|
      product = Product.find_by(code: item[:code])

      item[:quantity].to_i.times do
        add(product)
      end
    end
  end
end
