class BuyersController < ApplicationController
  def create
    @result = CreateBuyerAccount.perform(buyer_params)

    if @result.success?
      render json: @result.buyer_account, status: :created
    else
      render json: { errors: @result.errors }, status: :unprocessable_entity
    end
  end

  private

  def buyer_params
    params
      .require(:new_buyer)
      .permit(:token, :card_last_four, :card_type)
      .merge(person: current_person)
  end
end
