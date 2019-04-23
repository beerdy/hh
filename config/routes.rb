Rails.application.routes.draw do

  resources :reservations
  resources :reviews
  
  mount Ckeditor::Engine => '/ckeditor'
  
  get 'pages/dorado'
  get 'pages/bavariya'
  get 'pages/contacts'

  resources :galleries
  root 'main#index'

  resources :events do
    collection do
      get :search
    end
  end
  get 'events/search/:tag', to: 'events#search'
  
  resources :messages
  resources :carts
  resources :histories
  
  resources :products do
    collection do
      get :search
    end
  end
  get 'products/search/:tag', to: 'products#search'
  
  resources :contents
  resources :orders
  devise_for :users
  resources :users

  resources :bonuses do
    collection do
      get :get
      get :add
    end
  end
  get  'bonuses/prize/:card_id',    to: 'bonuses#get'
  get  'bonuses/add/:card_id/:sum', to: 'bonuses#add'
  post 'bonuses/move_bonuses',  controller: 'bonuses', action: 'move_bonuses',  as: "move_bonuses"
  post 'bonuses/prize', controller: 'bonuses', action: 'prize', as: "bonuses_prize"        # for admin
    
  post   'cart_item/add',    controller: 'carts',  action: 'add',       as: "cart_item_add"            # add position by id and count in post request
  delete 'cart_item/delete', controller: 'carts',  action: 'delete',    as: "cart_item_delete" # delete position by id all quantify
  get    'cart_item/remove', controller: 'carts',  action: 'remove',    as: "cart_item_remove"    # remove cart user
  get    'cart_item',        controller: 'carts',  action: 'cart_item', as: "cart_item_show"          # show cart user

  get 'orders_list', controller: 'orders',  action: 'orders_list', as: "orders_list_show"          # show cart user

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ЗаглушкИ для несуществующих routes. К примеру картинок подгружаемых библиотеками JS
  get '/images/thumb/missing.png', controller: 'main',  action: 'missing', :defaults => { :format => 'json' } 
end
