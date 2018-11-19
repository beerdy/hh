Rails.application.routes.draw do

  resources :orders
  root 'main#index'

  resources :events
  resources :messages
  resources :carts
  resources :histories
  resources :products
  resources :contents
  #resources :users
  devise_for :users
  resources :bonuses do
    collection do
      get :get
      get :move
      get :add
    end
  end
  get 'bonuses/get/:card_id', to: 'bonuses#get'
  get 'bonuses/move/:card_id_from/:card_id_to/:sum', to: 'bonuses#move'
  get 'bonuses/add/:card_id/:sum', to: 'bonuses#add'
    
  post 'cart_item/add', controller: 'carts',  action: 'add', as: "cart_item_add"            # add position by id and count in post request
  delete 'cart_item/delete', controller: 'carts',  action: 'delete', as: "cart_item_delete" # delete position by id all quantify
  get 'cart_item/remove', controller: 'carts',  action: 'remove', as: "cart_item_remove"    # remove cart user
  get 'cart_item', controller: 'carts',  action: 'cart_item', as: "cart_item_show"          # show cart user

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
