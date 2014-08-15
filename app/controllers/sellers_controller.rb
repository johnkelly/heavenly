class SellersController < ApplicationController
  def create
    @result = CreateSellerAccount.perform(seller_params)

    if @result.success?
      render json: @result.seller_account, status: :created
    else
      render json: { errors: @result.errors }, status: :unprocessable_entity
    end
  end

  private

  def seller_params
    params
      .require(:new_seller)
      .permit(:token, :card_last_four, :card_type)
      .merge(person: current_person)
  end
end
