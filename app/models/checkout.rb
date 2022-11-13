class Checkout < ApplicationRecord
  belongs_to :product
  belongs_to :basket

  after_commit :store_price_of_products

  private

  def store_price_of_products
    price = basket.products.sum(:price)
    basket.update_attribute(:checkout_price, price)
  end
end
