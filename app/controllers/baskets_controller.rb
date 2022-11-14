class BasketsController < ApplicationController
  def create
    @basket = Basket.create
    basket.add_list_of_products(basket_params)

    if discount_requested?
      discount_service.apply_discounts
    end

    render json: basket, status: :created

  rescue ActiveRecord::AssociationTypeMismatch
    render json: { errors: "Please make sure the product is one of either #{Product.codes.map(&:first)}" },
      status: :unprocessable_entity
  end

  private

  attr_reader :basket

  def discount_requested?
    params[:data][:discount] == 'true'
  end

  def basket_params
    params.require(:data).require(:relationships).require(:products).require(:data)
  end

  def discount_service
    DiscountService.new(basket)
  end
end
