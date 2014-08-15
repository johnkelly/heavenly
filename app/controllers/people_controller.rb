class PeopleController < ApplicationController
  def show
    render json: current_person, serializer: CurrentPersonSerializer, status: :ok
  end
end
