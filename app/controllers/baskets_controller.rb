class BasketsController < ApplicationController
  def create
    basket = Basket.create
    basket.add_list_of_products(basket_params)

    render json: basket, status: :created

  rescue ActiveRecord::AssociationTypeMismatch
    render json: { errors: "Please make sure the product is one of either #{Product.codes.map(&:first)}" },
      status: :unprocessable_entity
  end

  private

  def basket_params
    params.require(:data).require(:relationships).require(:products).require(:data)
  end
end
