Rails.application.routes.draw do
  namespace :auth do
    resource :facebook, only: %w(create)
  end

  resource :person, only: %w(show)
  resource :address, only: %w(create)
  resource :buyer, only: %w(create)
  resource :seller, only: %w(create)
end
