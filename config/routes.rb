Rails.application.routes.draw do
  resources :activities

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_users_session
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :moments

  resources :maps do 
    get '/geojson' => 'maps#geojson'
    post '/send_link_to_friend' => 'maps#send_link_to_friend'
  end

  resources :users do
    post '/follow' => 'users#add_friend_profile'
    get '/friends' => 'users#friends'
    post '/friends' => 'users#add_friend'
    delete '/friends' => 'users#remove_friend'
    get '/geojson' => 'users#geojson'
  end
  
  get '/geojson' => 'welcome#geojson'
  get '/about' => 'welcome#about'

  get '/act/:id' => 'activities#item'
  
  post 'instagram_photo' => 'moments#instagram_photo'
  #post 'get_instagram_photo' => 'moments#get_instagram_photo'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
