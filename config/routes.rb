Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders, only: [:index,:show,:update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    resources :items, only: [:top,:index,:show]
    resources :customers, only: [:show,:edit,:update,:unsubsribe,:withdraw]
    resources :cart_items, only: [:index,:update,:destroy,:destroy_all,:create]
    resources :orders, only: [:index,:show,:update]
    resources :addresses, only: [:index,:edit,:create,:update,:destroy]
  end
end
