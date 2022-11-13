class BasketSerializer < BaseSerializer
  attributes :checkout_price, :updated_at

  def checkout_price
    format_price(object.checkout_price)
  end
end
