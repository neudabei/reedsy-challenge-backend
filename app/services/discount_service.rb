class DiscountService
  TSHIRT_DISCOUNT = 30

  def initialize(basket)
    @basket = basket
  end

  def apply_discounts
    store_checkout_price_after_discount
  end

  private

  attr_reader :basket

  def store_checkout_price_after_discount
    basket.update_attribute(:checkout_price, checkout_price_after_discounts)
  end

  def checkout_price_after_discounts
    discounted_price_for_hoodies + discounted_price_for_tshirts + discounted_price_for_mugs
  end

  def discounted_price_for_hoodies
    basket.products.price_for_all_hoodies
  end

  def discounted_price_for_tshirts
    discount_factor = (100.to_f - tshirt_discount_percentage.to_f) / 100
    basket.products.price_for_all_tshirts * discount_factor
  end

  def discounted_price_for_mugs
    discount_factor = (100.to_f - mug_discount_percentage.to_f) / 100
    basket.products.price_for_all_mugs * discount_factor
  end

  def tshirt_discount_percentage
    tshirts_discountable? ? TSHIRT_DISCOUNT : 0
  end

  def mug_discount_percentage
    0 unless mugs_discountable?

    if mug_products_in_basket.size > 150
      30
    else
      calculate_mug_discount
    end
  end

  def calculate_mug_discount
    mug_products_in_basket.size.floor(-1) / 5
  end

  def tshirts_discountable?
    tshirt_products_in_basket.size > 2
  end

  def mugs_discountable?
    mug_products_in_basket.size > 9
  end

  def mug_products_in_basket
    basket.products.mug
  end

  def tshirt_products_in_basket
    basket.products.tshirt
  end
end
