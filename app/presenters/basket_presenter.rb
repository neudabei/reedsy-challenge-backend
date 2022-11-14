class BasketPresenter
  def initialize(basket)
    @basket = basket
  end

  def product_summary
    basket.products.uniq.map do |product|
      { product.code => basket.products.where(code: product.code).count.to_s }
    end
  end

  private

  attr_reader :basket
end
