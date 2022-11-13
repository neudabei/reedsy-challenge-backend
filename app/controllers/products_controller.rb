class ProductsController < ApplicationController
  def index
    render json: Product.all
  end

  def update
    product = Product.find(params[:id])

    if product.update(product_params)
      render json: product
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end

  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Please make sure the product exists. You can use the GET /products endpoint for a list of all products.' },
           status: :not_found
  end

  private

  def product_params
    params.require(:data).require(:attributes).permit(:code, :name, :price)
  end
end
