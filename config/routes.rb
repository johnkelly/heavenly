Rails.application.routes.draw do
  namespace :auth do
    resource :facebook, only: %w(create)
  end

  resources :products,  only: %w(index create update show) do
    post 'sell', to: 'sells#create'
  end
  resources :questions, only: %w(create) do
    resources :answers,   only: %w(create)
  end

  resource :person,     only: %w(show)
  resource :address,    only: %w(create)
  resource :buyer,      only: %w(create)
  resource :seller,     only: %w(create)

  mount PgHero::Engine, at: 'admin/pghero'
  mount Searchjoy::Engine, at: 'admin/searchjoy'
  mount Sidekiq::Web => '/admin/sidekiq'
end
