Rails.application.routes.draw do
  root 'public/homes#top'
  devise_for :customers, controllers: {
    sessions:      'public/sessions',
    passwords:     'public/passwords',
    registrations: 'public/registrations'
    }
  devise_for :admins, controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
    registrations: 'admin/registrations'
    }

  namespace :admin do
    get '/admin' => '/homes#top'
    patch 'order_details/update'
  end
  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :update, :edit] do
  end
  end
  namespace :admin do
    resources :genres, only: [:create, :index, :show, :destroy, :update, :edit] do
    end
    patch 'genres/:id/edit' => 'genres#edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :admin do
    resources :orders, only: [:index, :update, :show] do
  end
    patch 'orders/update'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :public do
    resources :orders, only: [:new, :create, :index, :show] do
    end
    post 'orders/confirm'
    get 'orders/complete'
  end
  namespace :public do
    resources :items, only: [:index, :show] do
    end
  end
  namespace :public do
    resources :addresses, only: [:create, :index, :destroy, :update, :edit] do
    end
  end
  namespace :public do
    resources :cart_items, only: [:create, :index, :destroy, :update] do
  end
    delete 'cart_items/destroy_all'
    
  end
  namespace :public do
    resources :customers, only: [:show, :edit, :update] do
  end
    patch ':id/withdraw/:name' => 'homes#withdraw', as: 'withdraw_customer'
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    patch "/customers/:id/hide" => "customers#hide", as: 'customers_hide'
  end
end
