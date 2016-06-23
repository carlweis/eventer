Rails.application.routes.draw do
  root 'events#index'
  resources :events do
    get :join, to: 'events#join', as: 'join'
    get :accept_request, to: 'events#accept_request', as: 'accept_request'
    get :reject_request, to: 'events#reject_request', as: 'reject_request'

  end

  devise_for :users

  get 'tags/:tag', to: 'events#index', as: :tag

end
