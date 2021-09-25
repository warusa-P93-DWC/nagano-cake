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
    resources :items
    #   resource do
    #   get 'get_jenre_children', defaults: { format: 'json' }
    #   get 'get_jenre_grandchildren', defaults: { format: 'json' }
    # end
    # customer do
    #   get 'purchase', to: 'items#purchase'
    #   post 'order', to: 'items#buy'
    # end

    # patch 'items/update'
  end
  namespace :admin do
    resources :genres, only: [:create, :index, :show, :destroy, :update, :edit] do
    end
    patch 'genres/:id/edit' => 'genres#edit',as: 'admin_genre'
  end
  namespace :admin do
    resources :customers
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :admin do
    resources :orders
    # get 'orders/index'
    # get 'orders/show'
    # patch 'orders/update'
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
    resources :items
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
    post 'addresses/create'
    delete 'addresses/destroy'
    patch 'addresses/update'
  end
  namespace :public do
    delete 'cart_items/destroy_all'
    resources :cart_items
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    patch 'customers/update'
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
  end
end
