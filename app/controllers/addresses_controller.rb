class AddressesController < ApplicationController
  def create
    @address = current_person.build_address(address_params)

    if @address.save
      render json: @address, status: :created
    else
      render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params
      .require(:address)
      .permit(:street1, :street2, :city, :region, :postal_code, :country, :latitude, :longitude)
  end
end
