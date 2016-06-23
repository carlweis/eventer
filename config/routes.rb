Rails.application.routes.draw do
  root 'events#index'
  resources :events
  devise_for :users

  get 'tags/:tag', to: 'events#index', as: :tag
end
