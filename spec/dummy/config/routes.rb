Rails.application.routes.draw do
  mount Platforms::Yammer::Engine => "/platforms-yammer"

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :post]

  # This is to enable RSpec testing
  get :create, to: 'sessions#create'

end
