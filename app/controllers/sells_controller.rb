class SellsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @result = SellProduct.perform(sell_params)

    if @result.success?
      render json: @result.sell_receipt, status: :created
    else
      render json: { errors: @result.errors }, status: :unprocessable_entity
    end
  end

  def sell_params
    params
      .require(:sell)
      .permit(:pickup_at)
      .merge({ person: current_person, product: @product })
  end
end
