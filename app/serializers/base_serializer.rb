class BaseSerializer < ActiveModel::Serializer
  def format_price(price)
    sprintf("%.2f", price.to_f / 100)
  end
end
