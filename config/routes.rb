Rails.application.routes.draw do

  get '/search' => 'search#search'
  # customer側ルーティング
  devise_for :customers, controllers: {
   sessions:      'public/customers/sessions',
   passwords:     'public/customers/passwords',
   registrations: 'public/customers/registrations'
  }

  # admin側ルーティング
  devise_for :admins, controllers: {
   sessions:      'admin/admins/sessions',
   passwords:     'admin/admins/passwords',
   registrations: 'admin/admins/registrations'
  }






  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
    resources :genres, only: [:index,:create,:edit,:update]
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders, only: [:index,:show,:update]
    resources :order_details, only: [:update]
    get 'admin/tops' => 'tops#top'
    get 'customerindex' => "orders#customerindex"
  end

  scope module: :public do
    root 'items#top'
    get 'about' => 'items#about'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
    get 'unsubscribe' => 'customers#unsubscribe'
    delete 'cart_items' => 'cart_items#all_destroy', as: 'all_destroy'
    resources :genres, only: [:show]
    resources :items, only: [:index,:show]

    resources :customers, only: [:show,:edit,:update]
    resources :cart_items, only: [:index,:update,:destroy,:destroy_all,:create]

    get 'orders/confirm' => 'orders#confirm', as: 'orders_confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:index,:show,:update,:new,:create]
    resources :addresses, only: [:index,:edit,:create,:update,:destroy]
  end
end

