class BasketSerializer < BaseSerializer
  attributes :product_summary, :total, :updated_at

  def product_summary
    basket_presenter.product_summary
  end

  def total
    format_price(object.checkout_price)
  end

  def basket_presenter
    BasketPresenter.new(object)
  end
end
