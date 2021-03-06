Rails.application.routes.draw do
  scope '/api' do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :albums, except: [:new, :edit], defaults: { format: :json } do
      resources :tracks, only: [:index, :create], defaults: {format:  :json} do
        resources :artists, only: [:index, :create], defaults: {format: :json}
      end
      resources :producers, only: [:index, :create], defaults: {format: :json}
    end
    resources :tracks, except: [:new, :edit], defaults: {format:  :json}  do
      resources :artists, only: [:index, :show], defaults: {format: :json}
    end
    resources :artists, except: [:new, :edit], defaults: {format: :json} do
      resources :tracks, only: [:index], defaults: {format: :json}
      resources :albums, only: [:index, :show], defaults: {format: :json}
    end
    resources :producers, except: [:new, :edit], defaults: {format: :json} do
      resources :albums, only: [:index, :show], defaults: {format: :json}
    end
    resources :posts, except: [:new, :edit], defaults: {format: :json}
    resources :users, except: [:new, :edit], defaults: {format: :json} do
      resources :posts, only: [:index, :show], defaults: {format: :json}
      resources :playlists, only: [:index, :show, :update], defaults: {format: :json}
    end
    resources :playlists, except: [:new, :edit], defaults: {format: :json} do
      resources :tracks, only: [:index], defaults: {format: :json}      
    end
    match "/assets/audio/tracks/:id/:basename.:extension", controller: "tracks", action: "download", via: :get
    post "/tracks/tokens", controller: "tracks", action: "generate_token"
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
