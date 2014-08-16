class ProductsController < ApplicationController
  def index
    term = params.fetch('term') { '*' }
    latitude = params.fetch('latitude') { current_person.address.latitude }
    longitude = params.fetch('longitude') { current_person.address.longitude }

    @products = Product.search_within_ten_miles(latitude.to_d, longitude.to_d, term)
    render json: @products, status: :ok
  end

  def create
    @product = current_person.sold_products.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    render json: @product, status: :ok
  end

  private

  def product_params
    params
      .require(:product)
      .permit(:title, :description, :video_url, :price, :on_sale)
  end
end
