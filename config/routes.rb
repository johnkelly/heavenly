Rails.application.routes.draw do
  namespace :auth do
    resource :facebook, only: %w(create)
  end

  resource :person, only: %w(show)
end
