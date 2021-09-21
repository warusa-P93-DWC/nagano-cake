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
    get 'items/new'
    post 'items/create'
    get 'items/edit'
    get 'items/show'
    get 'items/index'
    patch 'items/update'
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
    get 'orders/index'
    get 'orders/show'
    patch 'orders/update'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :public do
    get 'orders/new'
    post 'orders/confirm'
    post 'orders/create'
    get 'orders/complete'
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
    post 'addresses/create'
    delete 'addresses/destroy'
    patch 'addresses/update'
  end
  namespace :public do
    get 'cart_items/index'
    delete 'cart_items/destroy'
    patch 'cart_items/update'
    delete 'cart_items/destroy_all'
    post 'cart_items/create'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    patch 'customers/update'
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
  end
end
