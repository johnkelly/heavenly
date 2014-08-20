class BuysController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @result = BuyProduct.perform(buy_params)

    if @result.success?
      render json: @result.order, status: :created
    else
      render json: { errors: @result.errors }, status: :unprocessable_entity
    end
  end

  def buy_params
    params
      .require(:buy)
      .permit(:deliver_at)
      .merge(person: current_person, product: @product)
  end
end
